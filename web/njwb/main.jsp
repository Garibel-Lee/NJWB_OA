<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>main.html</title>

    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>

    <style type="text/css">
        .hide {
            display: none;

        }
    </style>
    <script type="text/javascript">
        $(function () {
            //找到所有的li,且class=menu
            //alert($("li[class='menu']").length);


            //存在的问题：一级菜单和二级菜单能正常的显示与隐藏，但是当点击二级菜单，发现二级菜单也跟着隐藏

            //吸取一个经验：在网页元素排版时，要兼顾后期的js操作
            //一个合理的网页布局，会让js获取元素时非常遍历，否则就很痛苦
            /**
             $("li[class='menu']").each(function(){
   		  	  $(this).click(function(){
   		  	      $(this).children(".hide").slideToggle();
   		  	  });
   		  
   		  });
             */

            //对所有的span标签设置单击事件

            //alert($("span").length);  4个

            //alert($("li[class='menu'] span").length);

            $("li[class='menu'] span").each(function () {
                $(this).click(function () {
                    //this代表的是span
                    $(this).siblings(".hide").slideToggle();

                });

            });

        });

    </script>


</head>

<body>
<div id="mainDiv">
    <div id="header">
        <div id="logoDiv" class="lft">
            南京网博教育集团
        </div>
        <div id="userDiv" class="rft">
            ${param.userName}
        </div>
    </div>
    <div id="welcomeDiv">
        欢迎使用网博管理系统
    </div>


    <div id="contentDiv">
        <div id="content-left" class="lft">

            <ul>
                <c:forEach items="${roleMap}" var="role">
                    <li class="menu">
                        <span>${role.key.menuName}</span>
                        <ul class="hide">
                            <c:forEach items="${role.value}" var="menu">
                            <li class="menu-sub"><a href="${menu.hrefUrl}" id="${menu.id}" target="contentPage">${menu.menuName}</a>
                            </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:forEach>
            </ul>


        </div>

        <div id="content-right" class="rft">
            <iframe id="contentPage" src="" name="contentPage" scrolling="yes" frameborder="0" width="788px" height="470px">
            </iframe>
        </div>
    </div>

    <div id="footer">
        <span>&copy;版权归属南京网博江北总部</span>
    </div>

</div>

</body>
</html>
