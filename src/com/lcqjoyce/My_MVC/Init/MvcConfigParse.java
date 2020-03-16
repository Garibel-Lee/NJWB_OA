package com.lcqjoyce.My_MVC.Init;


import com.lcqjoyce.My_MVC.Model.Action;
import com.lcqjoyce.My_MVC.Model.MyPackage;
import com.lcqjoyce.My_MVC.Model.Result;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class MvcConfigParse {
	//解析权限的xml
	//dom中的sax
	private static Logger logger = Logger.getLogger(MvcConfigParse.class);
	private static MvcConfig mvc = new MvcConfig();
	static{
		InputStream is = MvcConfigParse.class.getClassLoader().getResourceAsStream("mvc.xml");
		SAXReader reader = new SAXReader();
		Document dom= null;
		//加载文件
		try {
			dom=reader.read(is);
			logger.debug("mvc.xml文件读取成功");
		} catch (DocumentException e) {
			logger.warn("mvc.xml文件异常");
			e.printStackTrace();
		}
		if(null!=dom){
			//解析xml文件
			logger.debug("mvc.xml开始解析");

			List<Element> packages = dom.selectNodes("/mvc/package");
			for (Element elePackage : packages) {
				MyPackage myPackage = new MyPackage();
				String packageName = elePackage.attributeValue("name").trim();
				if(null==packageName || packageName.equals("")){
					logger.warn("package标签少name属性");
					throw new RuntimeException("package标签少name属性");
				}else{
					logger.debug(packageName);
					myPackage.setName(packageName);
				}
				String namespace = elePackage.attributeValue("namespace").trim();
				if(null==namespace || namespace.equals("")){
					logger.debug("package标签namespace属性使用默认值");
					myPackage.setNamespace("/");
				}else{
					myPackage.setNamespace(namespace);
				}
				//搞定下面的action

				List<Element> actions = elePackage.elements("action");
				logger.debug("解析名为："+packageName+"下的action");
				for (Element eleAction : actions) {
					Action action = new Action();
					String actionName=eleAction.attributeValue("name").trim();
					if(null== actionName || actionName.equals("")){
						logger.warn("action标签少name属性");
						throw new RuntimeException("action标签少name属性");
					}else{
						action.setName(actionName);
					}
					String method = eleAction.attributeValue("method").trim();
					if(null==method || method.equals("")){
						logger.debug("action标签method属性使用默认值");
						action.setMethod("execute");
					}else{
						action.setMethod(method);
					}
					//获得相应的类
					String className=eleAction.attributeValue("class").trim();
					if(null== actionName || actionName.equals("")){
						logger.warn("action标签少name属性");
						throw new RuntimeException("action标签少class属性");
					}else{
						action.setClassName(className);
					}
					//解析result集合

					List<Element> results = eleAction.elements("result");
					logger.debug("解析名为"+actionName+"的action下的result");
					for (Element eleResult : results) {
						Result result = new Result();
						String nameResult = eleResult.attributeValue("name").trim();
						if(null==nameResult || nameResult.equals("") ){
							logger.debug("result标签name属性使用默认值");
							result.setName("success");
						}else{
							result.setName(nameResult);
						}
						String type = eleResult.attributeValue("type").trim();
						if(null==type || type.equals("")){
							logger.debug("result标签type属性使用默认值");
							result.setType("dispatcher");
						}else{
							System.out.println(
									type
							);
							result.setType(type);
						}
						String str =eleResult.getTextTrim();
						if(null==str || str.equals("")){
							logger.warn("result标签没有给出要跳转的位置，也就是标签之间没有内容");
							throw new RuntimeException("result标签没有给出要跳转的位置，也就是标签之间没有内容");
						}else{
							result.setContent(str);
						}
						//放到action中
						action.setResult(nameResult, result);
					}
					//把action加入到package中
					myPackage.setAction(actionName, action);
				}
				//命名空间的键值对
				mvc.setPackage(namespace, myPackage);
				
			}
			logger.debug("authority.xml解析完毕");
			try {
				is.close();
				logger.debug("mvc.xml文件关闭");
			} catch (IOException e) {
				logger.warn("mvc.xml文件关闭异常");
				e.printStackTrace();
			}
		}
	}
	//返回解析好的mvc
	public static  MvcConfig getMvcConfig(){
		return  mvc;
	}

}
