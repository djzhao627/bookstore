<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<jsp:include page="../static/head.html"/>
	<script src="js/jquery.min.js"></script>
	<script src="js/cityselect.js"></script>
	<link href="js/cityLayout.css" type="text/css" rel="stylesheet">
<script src="js/order.js"></script>
	<script>
		$(function(){
			init_city_select($("#selectArea"));
		});

	</script>
</head>
<body>
<div id="header" class="wrap">
	<div id="logo"><img src="images/logo.png" /></div>
	<div class="help">
		<a href="cartPage.do" class="shopping">查看购物车</a>
		<c:if test="${sessionScope.user!=null}"><a href="userOrder.do?uid=${sessionScope.user.uid}">我的订单</a>&nbsp;用户:${sessionScope.user.uname}&nbsp;&nbsp;<a href="updateUserPage.do">更新个人信息</a><a href="updatePwdPage.do">修改密码</a><a href="logout.do">注销</a></c:if>
		<c:if test="${sessionScope.user==null}">
			<button type="button" class="btn btn-default" onclick="window.location.href='login.do'">登陆</button>
			<button type="button" class="btn btn-default" onclick="window.location.href='reg.do'">注册</button>
		</c:if>
	</div>
	<div class="navbar">
		<button type="button" onclick="window.location.href='index.do'" class="btn btn-warning btn-lg ">首页</button>
		<div class="searchBook">
			<form method="post" action="productList.do">
				查找书籍：<input  type="text" class="text" name="key" placeholder="请输入商品关键字"  /> <input class="btn btn-info" type="submit" name="submit" value="搜索" />
			</form>
		</div>
	</div>
</div>
<div id="childNav">
	<div class="wrap">
		<ul class="clearfix">
			<c:forEach items="${bts}" var="bt">
			<li><a href="productList.do?type=${bt}" >${bt}</a></li>
			</c:forEach>
		</ul>
	</div>
</div>
<div class="wrap">
<div class="main">
		<h2>确认收货地址</h2>
		<hr/>
		<div class="manage">
			<form action="addBookOrder.do" id="orderForm">
				<table class="table table-hover">
					<tr>
						<td class="field">收货人：
						<input id="uid" name="uid" type="hidden" value="${sessionScope.user.uid}" />
						</td>
						<td><input type="text" class="text" id="oname" name="oname" value="${sessionScope.user.uname }"/></td>
					<tr>
						<td class="field">手机号码：</td>
						<td><input type="text" class="text" id="omobile" name="omobile" value="${sessionScope.user.phone }" /></td>
					</tr>
					<tr>
						<td class="field">送货地址：</td>
						<td>
							<input name="ocity" id="selectArea"  type="text" value="江苏省-南京市-江宁区" class="city_input" readonly="readonly">
							<br>
							<textarea placeholder="输入详细地址" class="form-control" style="width:200px;height:100px;" id="oaddress" name="oaddress" value="${sessionScope.user.adress }" /></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<h2>确认订单信息</h2>
	<div id="shopping">
	<c:if test="${sessionScope.cart.totalPrice!=0}">
		<form action="shopping-result.html">
			<table>
				<tr>
					<th>商品名称</th>
					<th>单价（元）</th>
					<th>购买数量</th>
					<th>金额（元）</th>
					
				</tr>
 					<c:forEach var="good" items="${sessionScope.cart.goods}">   
					<tr id="product_id_1">
					<td class="thumb"><img height="80" width="80" src="images/product/${good.key.image}" /><a href="bookView.do?bid=${good.key.bid}">${good.key.bname}</a></td>
					<td class="price" >
						<span>￥${good.key.pirce}</span>
						<input id="price${good.key.bid}" type="hidden" value="${good.key.pirce}" />
					</td>
					<td class="number">
						<a id="number${good.key.bid}" name="number">${good.value}</a>
					</td>
					<td class="price">
						<span >￥</span>
						<span id="goodSum${good.key.bid}">${good.key.pirce*good.value}</span>
					</td>
					
				</tr>
					</c:forEach>
				
				<tr>
					<td colspan="" rowspan="" headers="">合计金额</td>
						<td colspan="" rowspan="" headers=""></td>
						<td colspan="" rowspan="" headers=""></td>
						
						<td class="price" id="price_id_1">
						<span>￥</span>
						<span id="sum">${sessionScope.cart.totalPrice }</span>
						<input id="hiddenSum" type="hidden" value="${sessionScope.cart.totalPrice}" />
						</td>
				</tr>
			</table>
			<div class="button"><a href="cartPage.do">返回购物车</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="submit" href="#"><img src="images/orderSub.png"></a></div>
		</form>
		</c:if>
		<c:if test="${sessionScope.cart.totalPrice==0}">
					<img src="images/empty.jpg" />
				</c:if>
	</div>
</div>
<jsp:include page="../static/footer.html"/>
<script>
    var validator;
    $(document).ready(function () {
        $.validator.setDefaults({
        });

        validator = $("#orderForm").validate({
            rules: {
                oname: {
                    required: true
                },
                omobile: {
                    required: true,
                    minlength: 11,
                    maxlength: 11
                },
                oaddress: {
                    required: true
                }
            },
            messages: {
                oname: {
                    required: "必须填写收货人"
                },
                omobile: {
                    required: "必须填写电话",
                    minlength: "电话号码长度不正确",
                    maxlength: "电话号码长度不正确"
                },
                oaddress: {
                    required: "必须填写送货地址"
                }
            }
        });

    });

</script>
</body>
</html>

