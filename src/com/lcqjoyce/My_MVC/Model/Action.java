package com.lcqjoyce.My_MVC.Model;

import java.util.HashMap;
import java.util.Map;

/*mvcz action子标签 */
public class Action {
	private String name;//action的名字
	private String method="execute";//处理方法
	private String className;// 存入对应的类
	private Map<String, Result> results = new HashMap<String, Result>();//视图的结果的集合
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	//获得与设置集合，使用方便
	public void setResult(String name,Result result){
		this.results.put(name, result);
	}
	public Result getResult(String name){
		return this.results.get(name);
	}
//	public Map<String, Result> getResults() {
//	return results;
//}
//public void setResults(Map<String, Result> results) {
//	this.results = results;
//}
	@Override
	public String toString() {
		return "Action [name=" + name + ", method=" + method + ", results=" + results + "]";
	}
	
	
	
	
	

}
