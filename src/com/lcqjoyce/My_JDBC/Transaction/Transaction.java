package com.lcqjoyce.My_JDBC.Transaction;

public interface Transaction {
	//事务开启
	void begin(); 
	//事务提交
	void commit();
	//事务的回滚
	void rollback();
}
