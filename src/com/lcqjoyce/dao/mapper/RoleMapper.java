package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Role;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 21:51
 * @description：
 * @version: $
 */
public class RoleMapper implements RowMapper {
    private static Logger logger = Logger.getLogger(RoleMapper.class);

    @Override
    public List mapperList(ResultSet rs) throws SQLException {
        logger.debug("获得RoleMapper映射");
        List<Role> list = new ArrayList<Role>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while(rs.next()){
            System.out.println("rs不为空");
            Role role = new Role();
            role.setId(rs.getInt("t_id"));
            role.setRoleName(rs.getString("t_role_name"));
            try {
                role.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            } catch (NullPointerException e){
                logger.debug("datatime localtime日期转化 空指针失败");
                e.printStackTrace();
            }
            list.add(role);
        }
        logger.debug("RoleMapper数据分装成功");
        return list;
    }
}
