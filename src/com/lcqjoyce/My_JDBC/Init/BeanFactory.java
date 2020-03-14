package com.lcqjoyce.My_JDBC.Init;

import org.apache.log4j.Logger;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BeanFactory {
	private static Logger logger = Logger.getLogger(BeanFactory.class);
	//如果通过id获得对应的对象呢？通过键值对的方式，放置我们的对象
	//List（错） Map（对），把代码尽量都写成静态的，这样就可以，在程序加载时，自动完成， 提高效率，
	//同时所有用户使用的集合都是同一个，方便管理，不用新建过多的相同功能的对象
	private static Map<String, Object> beans = new HashMap<String, Object>();

	//如何解析,使用静态块进行解析，静态块的特点是，当类被加载的时候会自动执行，只执行一次
	static{
		InputStream is = BeanFactory.class.getClassLoader().getResourceAsStream("applicationContext.xml");
		SAXReader reader = new SAXReader();
		try {
			Document doc = reader.read(is);
			logger.debug("加载成功");
			List<Element> elements = doc.selectNodes("/beans/bean");
			logger.debug(elements);
			if(null!= elements && elements.size()>0){
				for (int i = 0; i <elements.size(); i++) {
					Element element = elements.get(i);
					//获得Id
					Attribute id = element.attribute("id");
					//获得class
					Attribute eleClass = element.attribute("class");
					//判断属性是否存在
					if(null==id || null== eleClass){
						logger.warn("bean中第"+i+"个标签不存在id或class属性");
						throw new RuntimeException("bean中第"+i+"个标签不存在id或class属性");
					}
					//通过反射获得对应的类
					Class clazz = Class.forName(eleClass.getText().trim());
					//创建该类的对象
					Object obj = clazz.newInstance();// 该类必须有默认构造函数
					//针对没有子标签，直接放入到集合中，如果有子标签，解析子标签
					List<Element> properties = element.elements("property");
					//判断是否存在
					if(null==properties || properties.size()==0){
						//不存在子标签
					}else{
						for (int j = 0; j < properties.size(); j++) {
							Element property = properties.get(j);
							//获得name与ref
							Attribute name = property.attribute("name");
							Attribute ref = property.attribute("ref");
							//通过name找对应的set方法，通过ref获得已经存在的bean
							if(null==name || null==ref){
								logger.warn("bean中第"+i+"个标签中的第"+j+"个property不存在name或ref属性");
								throw new RuntimeException("bean中第"+i+"个标签中的第"+j+"个property不存在name或ref属性");
							}
							String methodName = "set"+name.getText().trim().substring(0,1).toUpperCase()+name.getText().trim().substring(1);//加入set，第一个字母大写，后面不变
							//获得属性。getField只能获得可以访问的属性，与访问修饰符有关，
							//getDeclaredField 获得定义的属性，与访问修饰符无关，
							Field field = clazz.getDeclaredField(name.getText().trim());
							//反射对应的方法
							Method method = clazz.getMethod(methodName, field.getType());
							//通过ref属性获得对应的对象
							Object args = beans.get(ref.getText().trim());
							if(null==args){
								//没有找到对应的类
								logger.warn("在Map中没有找到名为"+ref.getText().trim()+"的类");
								throw new RuntimeException("在Map中没有找到名为"+ref.getText().trim()+"的类");
							}
							//调用方法,把对应的对象通过set方法赋值给对应对象
							method.invoke(obj, args);
						}
					}
					//把对象放入到对应的集合中
					beans.put(id.getText().trim(), obj);
				}
			}else{
				logger.warn("文档解析结构错误（/beans/bean）");
				throw new RuntimeException("文档解析结构错误（/beans/bean）");
			}
		} catch (DocumentException e) {
			logger.warn("文档异常");
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			logger.warn("class对应的类不存在");
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			logger.warn("方法异常");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//提供静态方法给用户使用，（通过id获得对应的对象）
	public static Object getObject(String id){
		Object result = beans.get(id);
		logger.debug(beans);
		if(null==result){
			logger.warn("在Map集合中，该"+id+"不存在");
			//程序出问题，NullPointerException
			throw new RuntimeException("在Map集合中，该"+id+"不存在");
		}
		return result;
	}


}
