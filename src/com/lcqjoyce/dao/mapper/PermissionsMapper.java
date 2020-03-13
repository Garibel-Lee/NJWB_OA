package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Menu;
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
public class PermissionsMapper implements RowMapper {
    private static Logger logger = Logger.getLogger(PermissionsMapper.class);
    public List<Menu> mapperList(ResultSet rs) throws SQLException {
        logger.debug("获得PermissionsMapper映射");
        List<Menu> list = new ArrayList<Menu>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while(rs.next()){
            System.out.println("rs不为空");
            Menu menu = new Menu();
            menu.setId(rs.getInt("t_id"));
            menu.setMenuName(rs.getString("t_menu_name"));
            menu.setHrefUrl(rs.getString("t_href_url"));
            menu.setParentId(rs.getInt("t_parent_id"));
            try {
                menu.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            } catch (NullPointerException e2){
                logger.debug("datatime localtime日期转化 空指针失败");
                e2.printStackTrace();
            }
            System.out.println(rs.getString("t_create_time"));

            list.add(menu);
        }
        logger.debug("MenuMapper数据分装成功");
        return list;
    }
}
