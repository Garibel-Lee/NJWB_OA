package com.lcqjoyce.My_MVC.Model;

/*mvcz result子标签 */
//处理结果，也就是要以何种方式跳转，显示对应的视图
public class Result {
	private String name="success";//result的名字要唯一，默认是成功
	private String type="dispatcher";//跳转方式,如果在标签中没有定义，默认是请求转发

	private String content;//标签之间的内容（内容必须写，不写，解析时人为报错）


	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Result() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Result [name=" + name + ", type=" + type + ", content=" + content + "]";
	}
	public Result(String name, String type, String content) {
		super();
		this.name = name;
		this.type = type;
		this.content = content;
	}
	
	
}
