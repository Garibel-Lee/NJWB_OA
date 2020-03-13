package com.lcqjoyce.My_JDBC.Handle;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

//T是泛型，代表任意用户传入的类型，
//谁传入的？就是要实现这个接口的类要传入的,
public interface RowMapper<T> {
	//用户给我什么类型，该接口的的方法就返回该类型的集合
	List<T> mapperList(ResultSet rs) throws SQLException;
}
