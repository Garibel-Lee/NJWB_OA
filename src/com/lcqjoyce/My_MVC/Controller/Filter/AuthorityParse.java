package com.lcqjoyce.My_MVC.Controller.Filter;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class AuthorityParse {
	//解析权限的xml
	//dom中的sax

	private static Logger logger = Logger.getLogger(AuthorityParse.class);
	private static List<String> authorityList = new ArrayList<String>();
	static{
		InputStream is = AuthorityParse.class.getClassLoader().getResourceAsStream("authority.xml");
		SAXReader reader = new SAXReader();
		Document dom= null;
		//加载文件
		try {
			dom=reader.read(is);
			logger.debug("authority.xml文件读取成功");
		} catch (DocumentException e) {
			logger.warn("authority.xml文件异常");
			e.printStackTrace();
		}
		if(null!=dom){
			//解析xml文件
			logger.debug("authority.xml开始解析");
			List<Element> items = dom.selectNodes("/items/item");
			for (Element element : items) {
				authorityList.add(element.getTextTrim());
			}
			logger.debug("authority.xml解析完毕");
			try {
				is.close();
				logger.debug("authority.xml文件关闭");
			} catch (IOException e) {
				logger.warn("authority.xml文件关闭异常");
				e.printStackTrace();
			}
		}
	}
	public static  List<String> getAuthorityList(){
		return  authorityList;
	}

}
