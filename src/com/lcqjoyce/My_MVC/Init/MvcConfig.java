package com.lcqjoyce.My_MVC.Init;

import com.lcqjoyce.My_MVC.Model.MyPackage;

import java.util.HashMap;
import java.util.Map;

public class MvcConfig {
	private Map<String, MyPackage>  packages = new HashMap<String, MyPackage>();

//	public Map<String, MyPackage> getPackages() {
//		return packages;
//	}
//
//	public void setPackages(Map<String, MyPackage> packages) {
//		this.packages = packages;
//	}
	//获得与设置集合，使用方便
	public void setPackage(String name,MyPackage myPackage){
		this.packages.put(name, myPackage);
	}
	public MyPackage getPackage(String name){
		return this.packages.get(name);
		
	}
	
}
