package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.Dept;
import com.lcqjoyce.util.page.PageResult;
import org.junit.Test;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 10:33
 * @description：
 * @version: $
 */
public class DeptDaoService {
    @Test
    public void deptServiceTest() {
        DeptService service=(DeptService) BeanFactory.getObject("deptService");
        List<Dept> lists=service.getAllDepts();
        for (Dept list : lists) {
            System.out.println(list.toString());
        }
    }
    @Test
    public void deptServiceOneTest() {
        DeptService service=(DeptService) BeanFactory.getObject("deptService");
       Dept lists=service.getByDeptNo("A0001");
        System.out.println(lists.toString());
    }
    @Test
    public void aest() {
        PermissionsService permissionsService=(PermissionsService)BeanFactory.getObject("permissionsService");
        PageResult permissionsResult = permissionsService.getPermissionsWithConditionByPage(null, null,1);
        System.out.println(permissionsResult.getListData());
    }
}
