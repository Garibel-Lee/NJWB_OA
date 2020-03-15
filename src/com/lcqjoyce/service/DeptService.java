package com.lcqjoyce.service;

import com.lcqjoyce.entity.Dept;

import java.sql.SQLException;
import java.util.List;

public interface DeptService {
    public List<Dept> getAllDepts() ;
    public Dept getByDeptNo(String deptNo) ;
    //int currentPage--当前页,int size--每一页显示的条数
    public int deleteByDeptNo(String deptNo);
    List<Dept> getDeptsPerPage(int currentPage,int size) throws SQLException;

    int addDept(Dept dept);

    int updateDept(Dept dept);
}
