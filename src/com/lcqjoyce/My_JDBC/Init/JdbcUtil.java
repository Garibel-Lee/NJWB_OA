package com.lcqjoyce.My_JDBC.Init;

import org.apache.commons.dbcp.BasicDataSourceFactory;
import org.apache.log4j.Logger;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class JdbcUtil {
	private static Logger logger = Logger.getLogger(JdbcUtil.class);
	//创建本地线程，目的保存用于的连接，方便实现事务功能，讲完如果大家不了解事务，可以补充
	private static ThreadLocal<Connection> local = new ThreadLocal<Connection>();
	//获得数据源
	private static DataSource dataSource;
	//通过静态块的代码完成对配置文件的读取
	static{
		//获得文件流
		InputStream is = JdbcUtil.class.getClassLoader().getResourceAsStream("dataSource.properties");
		//获取配置中的内容
		Properties properties = new Properties();
		//加载
		try {
			properties.load(is);
			logger.debug("文件加载成功");
			dataSource = BasicDataSourceFactory.createDataSource(properties);
			logger.debug("创建数据源成功");
		} catch (IOException e) {
			logger.warn("文件加载异常 IOException ");
			e.printStackTrace();
		} catch (Exception e) {
			logger.warn("创建数据源失败");
			e.printStackTrace();
		}
	}
	
	//获得连接
	public static Connection getConnection(){
		//首先判断本线程中是否已经有连接，如果有，就用已有的连接，如果没有创建一个新的连接，给用户，并把该连接放入到自己的线程中
		Connection connection = local.get();
		if(null == connection){
			try {
				connection = dataSource.getConnection();
				local.set(connection);
				logger.debug("获得连接数据源成功");
			} catch (SQLException e) {
				logger.warn("获得连接数据源失败");
				e.printStackTrace();
			}
			
		}
		
		return connection;
	}
	//关闭(一组，关闭ResultSet, preparedStatement,Connection)
	public static void close(ResultSet rs){
		if(null!=rs){
			try {
				rs.close();
				logger.debug("ResultSet关闭成功");
			} catch (SQLException e) {
				logger.warn("ResultSet关闭失败");
				e.printStackTrace();
			}
		}
	}
	
	public static void close(PreparedStatement pstmt){
		if(null!=pstmt){
			try {
				pstmt.close();
				logger.debug("PreparedStatement关闭成功");
			} catch (SQLException e) {
				logger.warn("PreparedStatement关闭失败");
				e.printStackTrace();
			}
		}
	}
	//默认是关闭连接
	public static void close(){
		Connection connection = local.get();
		if(null!=connection){
			try {
				connection.close();
				//清除线程中的连接
				local.remove();
				logger.debug("Connection关闭成功");
			} catch (SQLException e) {
				logger.warn("Connection关闭失败");
				e.printStackTrace();
			}
		}
	}
}
