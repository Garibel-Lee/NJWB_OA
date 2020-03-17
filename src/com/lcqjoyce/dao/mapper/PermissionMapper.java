package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Permissions;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 0:57
 * @description：
 * @version: $
 */
public class PermissionMapper implements RowMapper {
    private static Logger logger = Logger.getLogger(PermissionMapper.class);
    public List<Permissions> mapperList(ResultSet rs) throws SQLException {
        logger.debug("获得PermissionsMapper映射");
        List<Permissions> list = new ArrayList<Permissions>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while(rs.next()){
            System.out.println("rs不为空");
            Permissions permissions = new Permissions();
            permissions.setId(rs.getInt("t_id"));
            permissions.setMenuId(Integer.valueOf(rs.getString("t_menu_id")));
            permissions.setRoleId(Integer.valueOf(rs.getString("t_role_id")));

            try {
                permissions.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            } catch (NullPointerException e2){
                logger.debug("datatime localtime日期转化 空指针失败");
                e2.printStackTrace();
            }
            System.out.println(rs.getString("t_create_time"));

            list.add(permissions);
        }
        logger.debug("PermissionsMapper数据分装成功");
        return list;
    }
}
