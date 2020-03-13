package com.lcqjoyce.My_JDBC.Handle;

import com.lcqjoyce.My_JDBC.Init.JdbcUtil;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JdbcTemplate {
	private static Logger logger = Logger.getLogger(JdbcTemplate.class);
	
	/**
	 * 这个方法是针对执行增删改语句的
	 * @param sql 要执行sql语句
	 * @param objects 要传入的参数值
	 * @return  影响的行数
	 */
	public static int executeUpdate(String sql,Object ...objects) throws SQLException{
		int count =0;
		Connection connection = JdbcUtil.getConnection();
		PreparedStatement pstmt = null;
		try {
			pstmt = connection.prepareStatement(sql);
			logger.debug("获得数据库操作对象成功");
			//打印sql语句
			logger.info("sql--->\t"+sql);
			//给参数赋值
			if(null!=objects && objects.length>0){
				setParamters(pstmt, objects);
			}else{
				logger.info("paramters:\t[]");
			}
			//执行sql语句
			count = pstmt.executeUpdate();
			logger.debug("sql语句执行完毕");
		} catch (SQLException e) {
			logger.warn("数据库异常");
			e.printStackTrace();
			throw e;//抛出异常
		}finally {
//			关闭操作
			JdbcUtil.close(pstmt);
//			JdbcUtil.close();这个不能出现，进行增删改时数据表中的数据发生了变化，关闭连接要出现在事务管理的代码中，否则事务管理就没有任何意义
			//转账，一个账户的钱增加，一个账户的钱减少，（有两条sql语句，要么都执行成功，要么都不执行成功）
		}
		return count;
	}
	//针对查询的
	/**
	 * 下面这个方法叫做泛型方法
	 * <T>List<T> 第一个T代表要传入泛型，第二个List<T>代表函数要返回的类型
	 * @param sql 要执行的sql语句
	 * @param mapper 数据库行的映射
	 * @param objects 查询时所需的参数
	 * @return 返回查询的结果集合
	 */
	public static <T>List<T> executeQuery(String sql,RowMapper<T> mapper,Object ...objects) {
		List<T> result = new ArrayList<T>();//防止出现空指针异常
		Connection connection = JdbcUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = connection.prepareStatement(sql);
			logger.debug("获得数据库操作对象成功");
			//打印sql语句
			logger.info("sql--->\t"+sql);
			//给参数赋值
			if(null!=objects && objects.length>0){
				setParamters(pstmt, objects);
			}else{
				logger.info("paramters:\t[]");
			}
			//执行查询sql语句,有可能没有数据，没有查到数据是不用封装的
			rs = pstmt.executeQuery();
			//封装数据
			result = mapper.mapperList(rs);
			logger.debug("sql语句查询完毕");
		} catch (SQLException e) {
			logger.warn("数据库异常");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close();//查询时，不会改变表中的数据，所以可以直接关闭
		}
		
		return result;
	}
	/**
	 * 
	 * @param pstmt 数据库操作对象
	 * @param objects 参数值
	 * @throws SQLException 
	 */
	public static void setParamters(PreparedStatement pstmt,Object ...objects) throws SQLException{
		//创建一个StringBuffer 用于输出参数值
		StringBuffer sb = new StringBuffer("[");
		for (int i = 0; i < objects.length; i++) {
			//给PreparedStatement进行赋值
			pstmt.setObject(i+1, objects[i]);
			//字符串拼接
			sb.append(objects[i].toString()+",");
		}
		sb.append("]");
		//把多余的逗号去掉（最后一个值后面的逗号）
		sb.replace(sb.length() - 2, sb.length() - 1, "");
		//输出参数
		logger.info("paramters:\t"+sb.toString());
		
	}
}
