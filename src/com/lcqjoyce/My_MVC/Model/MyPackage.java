package com.lcqjoyce.My_MVC.Model;

import java.util.HashMap;
import java.util.Map;

/*解析mvc.xml*/
/*mvcz package子标签 */
public class MyPackage {
	private String name;//名字唯一
	private String namespace="/";//命名空间，默认是根目录
	private Map<String, Action> actions = new HashMap<String, Action>();//action的集合
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNamespace() {
		return namespace;
	}
	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}
	//获得与设置集合，使用方便
	public void setAction(String name,Action action){
		this.actions.put(name, action);
	}
	public Action getAction(String name){
		return this.actions.get(name);
		
	}
//	public Map<String, Action> getActions() {
//		return actions;
//	}
//	public void setActions(Map<String, Action> actions) {
//		this.actions = actions;
//	}
	@Override
	public String toString() {
		return "MyPackage [name=" + name + "\n, namespace=" + namespace + ",\n actions=" + actions + "]";
	}
	
	
}
