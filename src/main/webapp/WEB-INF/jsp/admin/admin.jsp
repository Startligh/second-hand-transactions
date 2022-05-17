<%@ page language="java" contentType="text/html;charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<style type="text/css">
		.background{
			background-image: url("${pageContext.request.contextPath}/img/showPic/1.png");
			background-size: cover;
			background-repeat:no-repeat ;
			background-attachment: fixed;
			position: fixed;
			height: 100%;
			width: 100%;
		}
	</style>

</head>
	<body class="background">

	<div class="layui-container" style="margin-top: 70px;">
		<div class="layui-row">
			<div class="layui-col-md6 layui-col-md-offset3">
				<form class="layui-form"  actiion="${pageContext.request.contextPath}/changeAdminPic" method="post" enctype="multipart/form-data">
					<div class="layui-col-md8 layui-col-md-offset2 " style="margin-top: 15px; text-align: center">
						<button type="button" class="layui-btn" style="background-color: #FFB800; width: 100%; height: 50px">
							<i class="layui-icon layui-icon-vercode" style="font-size: 30px; color: #FFFFFF; margin: 0 auto;">管理员后台</i>
						</button>
					</div>
					<div class="layui-col-md8 layui-col-md-offset2 " style="margin-top: 15px; text-align: center">
						<img style="margin: 15px 0" width="100px" height="100px" src="${pageContext.request.contextPath}/img/headPhoto/${userSession.apricture}">
					</div>
					<div class="layui-col-md8 layui-col-md-offset2 " style="margin-top: 15px; text-align: center">
						<button type="button" class="layui-btn" style="background-color: #1E9FFF;">
							<c:out value="${userSession.aname}"></c:out>
						</button>
					</div>
					<div class="layui-col-md8 layui-col-md-offset2 " style="margin-top: 15px; text-align: center">
						<button type="button" class="layui-btn" id="uploadAdminPic">
							<i class="layui-icon">&#xe612;</i>&nbsp;&nbsp;更换头像
						</button>
					</div>
					<div class="layui-col-md8 layui-col-md-offset1 " style="margin-top: 15px; text-align: center">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-fluid" id="userList">用户管理</button>
						</div>
					</div>
					<div class="layui-col-md8 layui-col-md-offset1 " style="margin-top: 15px; text-align: center">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-fluid" id="blackHome">小黑屋管理</button>
						</div>
					</div>
					<div class="layui-col-md8 layui-col-md-offset1 " style="margin-top: 15px; text-align: center">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-fluid" id="managerList">管理员列表</button>
						</div>
					</div>
					<div class="layui-col-md8 layui-col-md-offset1 " style="margin-top: 15px; text-align: center">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-fluid" id="addManager">添加管理员</button>
						</div>
					</div>
					<div class="layui-col-md8 layui-col-md-offset1 " style="margin-top: 15px; text-align: center">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-fluid" id="manageSlideshow">管理轮播图</button>
						</div>
					</div>
					<div class="layui-col-md8 layui-col-md-offset1 " style="margin-top: 15px; text-align: center">
						<div class="layui-input-block">
							<a href="${pageContext.request.contextPath}/admin/outLogin"><button type="button" class="layui-btn layui-btn-fluid" id="outLogin">退出系统</button></a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="layui/layui.js"></script>
	<script>
		layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
			var form = layui.form;
			var layer = layui.layer;
			var layedit = layui.layedit;
			var laydate = layui.laydate;
			var $=layui.jquery;

			$("#userList").click(function(){
				//点击用户列表时弹出一个弹出层
				layer.open(
						{
							type:2,
							title:'用户列表',    // 自动关闭所需毫秒：默认：0不会自动关闭
							time: 0,
							area:['80%','80%'],
							content:"${pageContext.request.contextPath}/admin/toUserList"
						});
			});

		});
	</script>
	<script>
		layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
			var form = layui.form;
			var layer = layui.layer;
			var layedit = layui.layedit;
			var laydate = layui.laydate;
			var $=layui.jquery;

			$("#managerList").click(function(){
				//点击管理员列表时弹出一个弹出层
				layer.open(
						{
							type:2,
							title:'管理员列表',    // 自动关闭所需毫秒：默认：0不会自动关闭
							time: 0,
							area:['80%','60%'],
							content:"${pageContext.request.contextPath}/admin/toManagerList"
						});
			});

		});
	</script>
	<script>
		layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
			var form = layui.form;
			var layer = layui.layer;
			var layedit = layui.layedit;
			var laydate = layui.laydate;
			var $=layui.jquery;

			$("#addManager").click(function(){
				//点击添加管理员时弹出一个弹出层
				layer.open(
						{
							type:2,    // 自动关闭所需毫秒：默认：0不会自动关闭
							time: 0,
							title:'添加管理员',
							area:['80%','60%'],
							content:"${pageContext.request.contextPath}/admin/toAddManager"
						});
			});

		});
	</script>

	<script>
		layui.use('upload', function(){
			var upload = layui.upload;

			//执行实例
			var uploadInst = upload.render({
				elem: '#uploadAdminPic' //绑定元素
				,url: '${pageContext.request.contextPath}/admin/uploadAdminPic' //上传接口
				,size: 1000
				,multiple: false//多文件上传
				,accept: 'images'
				,acceptMime: 'image/jpg, image/png'
				,done: function(result){
					//上传完毕回调
					if(result.msg != true){
						layer.msg(result.msg, {icon:5});
					}else if(result.msg == true){
						layer.msg("上传成功!",{icon:1});
					}else{
						layer.msg("上传失败!",{icon:5});
					}
					//延迟2s后刷新
					window.setTimeout(function () {
						window.location.reload();
					},2000)
				}
			});
		});
	</script>

	<script>
		layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
			var form = layui.form;
			var layer = layui.layer;
			var layedit = layui.layedit;
			var laydate = layui.laydate;
			var $=layui.jquery;

			$("#manageSlideshow").click(function(){
				//点击管理轮播图时弹出一个弹出层
				layer.open(
						{
							type:2,    // 自动关闭所需毫秒：默认：0不会自动关闭
							time: 0,
							title:'管理轮播图',
							area:['80%','80%'],
							content:"${pageContext.request.contextPath}/admin/toManageSlideshow"
						});
			});

		});
	</script>
	<script>
		layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
			var form = layui.form;
			var layer = layui.layer;
			var layedit = layui.layedit;
			var laydate = layui.laydate;
			var $=layui.jquery;

			$("#blackHome").click(function(){
				//点击管理小黑屋时弹出一个弹出层
				layer.open(
						{
							type:2,    // 自动关闭所需毫秒：默认：0不会自动关闭
							time: 0,
							title:'管理小黑屋',
							area:['80%','80%'],
							content:"${pageContext.request.contextPath}/admin/toBlackHome"
						});
			});

		});
	</script>
	</body>
</html>
