package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.DeptDao;
import com.lcqjoyce.dao.EmployeeDao;
import com.lcqjoyce.entity.Employee;
import com.lcqjoyce.service.EmployeeService;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 18:33
 * @description：
 * @version: $
 */
public class EmployeeServiceImpl implements EmployeeService {
    private static Logger logger = Logger.getLogger(EmployeeServiceImpl.class);
    private EmployeeDao employeeDao;
    private DeptDao deptDao;
    private Transaction transaction;

    @Override
    public List<Employee> getAllEmployees() {
       List<Employee>  lists=employeeDao.getAllEmployees();


       return lists;
    }

    @Override
    public List<Employee> getEmployeesPerPage(int currentPage, int size) {
        return employeeDao.getEmployeesPerPage(currentPage, size);
    }

    @Override
    public List<Employee> getQueryEmployees(String empName, String empNo) {

        logger.info(empName+"***************"+empNo);
        if((empName == null ||  "".equals(empName)) && (empNo == null ||  "".equals(empNo)))
            return employeeDao.getAllEmployees();
        else
            return employeeDao.getQueryEmployees(empName,empNo);

    }

    /**
     * 分页加高级查询
     * @param empName
     * @param empDept
     * @return
     */
    @Override
    public PageResult getEmployeesWithConditionByPage(String empName, String empDept,Integer currentPage) {
        int count = employeeDao.queryForCount(empName,empDept);
        if(count > 0){
            List<Employee> employees = employeeDao.queryByPage(empName,empDept,currentPage,4);
            return new PageResult(employees,count,Integer.valueOf(currentPage),4);
        }
        return PageResult.empty(4);
    }

    @Override
    public int getEmployeeByName(String deptManager) {
        return employeeDao.getEmployeeByName(deptManager);
    }

    @Override
    public int getEmployeeByNameAndDeptNo(String deptManager, String deptNo) {
        return employeeDao.getEmployeeByNameAndDeptNo(deptManager,deptNo);
    }

    /*
    		int count = flightDao.queryForCount(qo);
		if(count > 0) {
			List<Flight> list = flightDao.query(qo);
			return new PageResult(list, count, qo.getCurrentPage(), qo.getPageSize());
		}
		return PageResult.empty(qo.getPageSize());
     */








    @Override
    public int addEmployee(Employee emp) {
        int count = 0;
        logger.debug("EmployeeServiceImpl类中，addEmployee");
        try {
            //开始事务
            transaction.begin();
            count = employeeDao.addEmployee(emp);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("EmployeeServiceImpl类中,addEmployee方法出现异常");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public Employee getEmployeeByNo(String empNo) {


        return employeeDao.getEmployeeByNo(empNo);
    }

    @Override
    public int updateEmployee(Employee emp) {
        int count = 0;
        logger.debug("EmployeeServiceImpl类中，updateEmployee");
        try {
            //开始事务
            transaction.begin();
            count = employeeDao.updateEmployee(emp);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("EmployeeServiceImpl类中,updateEmployee");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int deleteEmployee(Employee emp) {
        int count = 0;
        logger.debug("EmployeeServiceImpl类中，deleteEmployee");
        try {
            //开始事务
            transaction.begin();
            count = employeeDao.deleteEmployee(emp);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("EmployeeServiceImpl类中,deleteEmployee");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;
    }



    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    public void setDeptDao(DeptDao deptDao) {
        this.deptDao = deptDao;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }
}
