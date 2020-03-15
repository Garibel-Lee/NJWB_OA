package com.lcqjoyce.DAO;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.dao.DeptDao;
import com.lcqjoyce.entity.Dept;
import org.junit.Test;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 10:33
 * @description：
 * @version: $
 */
public class DeptDaoTest {
    @Test
    public void deptTest() {
        DeptDao dao=(DeptDao) BeanFactory.getObject("deptDao");
        List<Dept> lists=dao.ListAll();
        for (Dept list : lists) {
            System.out.println(list.toString());
        }
    }
}
