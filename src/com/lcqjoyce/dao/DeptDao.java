package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Dept;

import java.sql.SQLException;
import java.util.List;

public interface DeptDao {
    public List<Dept> ListAll();
    public Dept getByDeptNo(String deptNo);
    List<Dept> getDeptsPerPage(int currentPage,int size) throws SQLException;

    int delteByDeptNo(String deptNo);

    int addDept(Dept dept);

    int updateDept(Dept dept);
}
