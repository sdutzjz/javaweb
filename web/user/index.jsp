<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2019/1/1
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>宿舍管理系统</title>
    <link rel="stylesheet" href="./statics/css/layui.css">
    <link rel="stylesheet" href="./statics/css/main.css">
</head>
<body>
<jsp:include page="layout/header.jsp" />
<div class="layui-container">
    <div class="layui-row main">
        <div class="layui-col-md8 message">
            <div class="layui-carousel" id="test1">
                <div carousel-item>
                    <div>条目1</div>
                    <div>条目2</div>
                    <div>条目3</div>
                    <div>条目4</div>
                    <div>条目5</div>
                </div>
            </div>
            <div class="message-content">
                <c:forEach items="${list_page}" var="message">
                <div class="layui-card">
                    <div class="layui-card-header">
                        <c:choose>
                            <c:when test="${message.getUser().image!=null}"><img src="${message.getUser().image}" alt="" class="layui-nav-img"></c:when>
                            <c:otherwise><img src="../statics/images/user.jpg" alt="" class="layui-nav-img"></c:otherwise>
                        </c:choose>
                        ${message.getUser().nickname}
                        <c:if test="${message.user_id == user.id}">
                        <a href="/dormitory/user/message/delete?id=${message.id}" class="close"><i class="layui-icon layui-icon-close"></i></a>
                        </c:if>
                    </div>
                    <div class="layui-card-body">
                        ${message.content}
                    </div>
                    <div class="card-footer">
                        <div class="card-footer-left"><span class="date">${message.created_at}</span></div>
                        <div class="card-footer-right">
                            <button class="layui-btn layui-btn-radius btn-praise layui-btn-primary" data-id = "${message.id}">
                                <i class="layui-icon layui-icon-praise"></i>
                                <span>${message.praise}</span>
                            </button>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
            <div class="layui-table-page">
                <div>
                    <div class="layui-box layui-laypage layui-laypage-default">
                        <%--上一页--%>
                        <c:if test="${page.page >0}">
                        <a href="/dormitory/user/index?page=${page-1}" class="layui-laypage-prev layui-disabled">
                            <i class="layui-icon"></i>
                        </a>
                        </c:if>
                            <%--当前页--%>
                            <span class="layui-laypage-curr">
                                <em class="layui-laypage-em">
                                </em>
                                <em>${page.page+1}</em>
                            </span>

                            <%--<a href="" class="layui-laypage-last" >100</a>--%>
                            <%--下一页--%>
                            <c:if test="${page.page+1 < page.pageNum}">
                            <a href="/dormitory/user/index?page=${page.page+1}" class="layui-laypage-next">
                                <i class="layui-icon"></i>
                            </a>
                            </c:if>
                            <%--跳转到第X页--%>
                            <%--<span class="layui-laypage-skip">--%>
                                <%--到第--%>
                                <%--<select name="" id="">--%>
                                    <%--<option value="1">1</option>--%>
                                <%--</select>--%>
                                <%--页--%>
                                <%--<button type="button" class="layui-laypage-btn" >确定</button>--%>
                            <%--</span>--%>
                    </div>
                </div>
            </div>
            <div class="new-message">
                <form action="/dormitory/user/message/create" class="layui-form" method="POST">
                    <div class="layui-row">
                        <div class="layui-col-md1">
                            <img class="layui-nav-img" src="../statics/images/user.jpg" alt="">
                        </div>
                        <div class="layui-col-md11">
                            <textarea name="content" class="layui-textarea" id="message"></textarea>
                            <div class="writer">
                                <button type="submit" class="layui-btn">留言</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="layout/sidebar.jsp"/>
    </div>
</div>
<jsp:include page="layout/script.jsp"/>
<script>
    layui.use('carousel', function(){
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            ,width: '100%' //设置容器宽度
            ,arrow: 'always' //始终显示箭头
            //,anim: 'updown' //切换动画方式
        });
    });
    layui.use(['jquery', 'layer'], function(){
        var $ = layui.$ //重点处
            ,layer = layui.layer;
        $('.btn-praise').click(function (e) {
            var flag = $(this).context.classList[5] == "layui-btn-disabled";
            if (flag)
            {
                return;
            }
            //发送ajax请求
            var id = $(this).data("id");
            var url = "${pageContext.request.contextPath}" + "/user/praise?id=" + id;
            var that = $(this);
            $.get(url,function (data) {
                var data = JSON.parse(data);
                if (data.code == 0){
                    console.log(data);
                    //code为0  点赞成功
                    that.addClass("praise-active layui-btn-disabled");
                    that.find('span').text(function (i,old) {
                        return Number(old) + 1;
                    })
                    layer.msg(data.message,{icon:1});
                }else {
                    console.log(data);
                    layer.errorMessage(data.message)
                    layer.msg(data.message,{icon:2});
                }
            })
        });
    });
    layui.use('layedit',function () {
        var layedit = layui.layedit;
        layedit.build('message',{
            uploadImage : {
                url:"${pageContext.request.contextPath}/images/upload",
                type: "POST",
            }
        }); //建立编辑器
    });
</script>
</body>
</html>
