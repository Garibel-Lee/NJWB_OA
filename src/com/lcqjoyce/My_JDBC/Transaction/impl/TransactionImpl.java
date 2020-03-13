package com.lcqjoyce.My_JDBC.Transaction.impl;


import com.lcqjoyce.My_JDBC.Init.JdbcUtil;
import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.SQLException;

public class TransactionImpl implements Transaction {
	private static Logger logger = Logger.getLogger(TransactionImpl.class);
	public void begin() {
		logger.debug("在TransactionImpl类中，调用begin方法");
		//开始时，获得连接，关闭数据库的自动提交
		Connection connection = JdbcUtil.getConnection();
		try {
			connection.setAutoCommit(false);
			logger.debug("数据库自动提交已经关闭");
		} catch (SQLException e) {
			logger.warn("数据库自动提交关闭，操作失败");
			//关闭连接
			JdbcUtil.close();
			e.printStackTrace();
		}

	}

	public void commit() {
		logger.debug("在TransactionImpl类中，调用commit方法");
//		代表程序执行成功，数据库中的数据永久的保存到数据库中
		Connection connection = JdbcUtil.getConnection();
		try {
			connection.commit();
			logger.debug("数据自动提交");
		} catch (SQLException e) {
			logger.warn("数据自动提交操作失败");
			//关闭连接
			e.printStackTrace();
		}finally{
			JdbcUtil.close();
		}

	}

	public void rollback() {
		logger.debug("在TransactionImpl类中，调用rollback方法");
//		代表程序执行失败，所有数据恢复到初始状态
		Connection connection = JdbcUtil.getConnection();
		try {
			connection.rollback();
			logger.debug("数据库回滚");
		} catch (SQLException e) {
			logger.warn("数据库回滚操作失败");
			e.printStackTrace();
		}finally{
			JdbcUtil.close();
		}

	}

}
