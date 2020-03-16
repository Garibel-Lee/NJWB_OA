package com.lcqjoyce.entity;

import com.lcqjoyce.dao.EmployeeDao;
import com.lcqjoyce.dao.impl.EmployeeDaoImpl;
import lombok.Data;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;


@Data
public class Employee {

    private Integer id;

    private String empNo;

    private String empName;

    private String empDept;

    private String sex;

    private String education;

    private String email;

    private String phone;

    private LocalDate entryTime;

    private LocalDate createTime;

    public static String getNumber() {

        String id = null;
        EmployeeDao dao = new EmployeeDaoImpl();
        List<Employee> lists = new ArrayList<>();
        lists = dao.getAllEmployees();
        Collections.sort(lists, new Comparator<Employee>() {
            public int compare(Employee o1, Employee o2) {
                // 升序
                //return o1.getAge()-o2.getAge();
                // return o1.getAge().compareTo(o2.getAge());
                // 降序
                // return o2.getAge()-o1.getAge();
                // return o2.getAge().compareTo(o1.getAge());
                return o2.getId().compareTo(o1.getId());
            }
        });
        String a = lists.get(0).empNo;
        int idnum = 0;
        try {
            idnum = Integer.parseInt(a.substring(a.length() - 4)) + 1;
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        DecimalFormat df = new DecimalFormat("0000");
        String aa = df.format(idnum);
        id = "E" + aa;
        return id;
    }

}
