<%--
  Created by IntelliJ IDEA.
  User: 11031
  Date: 2019/5/20
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>ajax测试_GET</title>
  <script type="text/javascript">
    /**
     * 1.在文档加载完成后
     *  *获取所有省，添加到<select id="province"}>中
     *  *给<select id="province">这个元素添加到onchange事件
     *      事件内容：
     *          1.获取当前选择的省id
     *      2.使用省id访问servlet，得到该省下所有的市
     *      3.把每个市添加到<select id="city">中
     */
    function createXMLHttpRequest() {
      try {
        return new XMLHttpRequest();
      } catch (e) {
        try {
          return new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
          return new ActiveXObject("Micorsoft.XMLHTTP");
        }
      }
    }

    window.onload = function () {
      /**
       * 发送异步请求，得到所有省，然后使用每个省生成一个<option>元素添加到<select id="province">中
       */
              //得到核心对象
      var xmlHttp = createXMLHttpRequest();
      //打开连接
      xmlHttp.open("GET", "<c:url value='/ProvinceServlet'/>", true);
      //发送
      xmlHttp.send(null);
      //添加监听
      xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4) {
          if (xmlHttp.status == 200) {
            //执行服务器发送过来的json字符串，得到js的对象
            var proArray = eval("(" + xmlHttp.responseText + ")");
            for(var i=0;i<proArray.length;i++){
              var pro=proArray[i];
              var optionEle=document.createElement("option");
              //给<option>元素的value赋值
              optionEle.value=pro.pid;//给<option>的实际赋值为pid，而不是name
              var textNode=document.createTextNode(pro.name);
              optionEle.appendChild(textNode);

              //把option元素添加到select元素中
              document.getElementById("province").appendChild(optionEle);
            }
          }
        }
      };

      /**
       * 2.给<select id="province">添加监听
       */
      document.getElementById("province").onchange=function(){
        //异步请求服务器，得到选择的省下所有市
        var xmlHttp = createXMLHttpRequest();
        //打开连接
        xmlHttp.open("POST", "<c:url value='/CityServlet'/>", true);
        //设置请求头
        xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        //发送
        xmlHttp.send("pid="+this.value);
        //添加监听
        xmlHttp.onreadystatechange = function () {
          if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
              /**
               * 1.得到服务器发送过来的所有市
               * 2.使用每个市生成<option>元素添加到<select id="city">中
               */
              /*
              清空<select id="city">中的选项
               */
              var citySelect = document.getElementById("city");
              //获取select中的子元素
              var cityOptionArray = citySelect.getElementsByTagName("option");
              while(cityOptionArray.length>1){
                citySelect.removeChild(cityOptionArray[1]);
              }

              /*
              得到服务器发送过来的所有的市
               */
              var cityList=eval("("+xmlHttp.responseText+")");
              //循环遍历每个city对象，用来生成<option>元素添加到<select id="city">中
              for(var i=0;i<cityList.length;i++){
                var city=cityList[i];
                var optionEle=document.createElement("option");
                //给<option>元素的value赋值
                optionEle.value=city.cid;//给<option>的实际赋值为pid，而不是name
                var textNode=document.createTextNode(city.name);
                optionEle.appendChild(textNode);

                //把option元素添加到select元素中
                citySelect.appendChild(optionEle);
              }
            }
          }
        };
      };
    };
  </script>
</head>
<body>
<h1>省市联动</h1>
<select name="province" id="province">
  <option value="">===请选择省份===</option>
</select>

<select name="city" id="city">
  <option value="">===请选择城市===</option>
</select>
</body>
</html>
