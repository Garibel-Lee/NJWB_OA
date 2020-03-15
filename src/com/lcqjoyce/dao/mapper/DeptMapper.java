package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Dept;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 10:29
 * @description：
 * @version: $
 */
public class DeptMapper  implements RowMapper {
    private static Logger logger = Logger.getLogger(DeptMapper.class);
    public List<Dept> mapperList(ResultSet rs) throws SQLException {
        logger.debug("获得t_dept表中数据，这是t_dept表与Dept类的映射");
        List<Dept> list = new ArrayList<Dept>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while(rs.next()){
            System.out.println("rs不为空");
            Dept dept = new Dept();
            dept.setDeptNo(rs.getString("t_dept_no"));
            dept.setDeptName(rs.getString("t_dept_name"));
            dept.setDeptLoc(rs.getString("t_dept_loc"));
            dept.setDeptManager(rs.getString("t_dept_manager"));
            dept.setDeptIntro(rs.getString("t_dept_intro"));
            try {
                dept.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            } catch (NullPointerException e2){
                logger.debug("datatime localtime日期转化 空指针失败");
                e2.printStackTrace();
            }
            System.out.println(rs.getString("t_create_time"));

            list.add(dept);
        }
        logger.debug("DeptMapper数据分装成功");
        return list;
    }
}
