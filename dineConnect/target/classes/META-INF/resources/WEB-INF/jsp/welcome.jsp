<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
	<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
	<title>Welcome Page</title>
	<style>
		body {
			background-image: url('<%= request.getContextPath() %>/images/bar-826687_1280.jpg');
			background-size: cover;
			background-position: center;
			background-repeat: no-repeat;
			margin: 0;
			overflow: hidden;
		}

		.high-container {
			height: calc(100vh - 56px); /* 네비게이션 바의 높이를 제외한 화면 전체 높이 설정 */
			display: flex;
			justify-content: center; /* 수평 가운데 정렬 */
			align-items: center; /* 수직 가운데 정렬 */
		}

		.reservation-btn-container {
			text-align: center;
		}

		.reservation-btn {
			margin-top: 20px; /* 버튼과 상단 간격 조정 */
		}
	</style>
</head>
<body>
<%@ include file="common/navigation.jspf"%>
<div class="high-container">
	<div class="container reservation-btn-container my-3 border p-4 rounded" style="max-width: 700px; background-color: rgba(255, 255, 255, 0.9);">
		<div class="row">
			<p class="fw-bold fs-2">Dine-Connect에 오신 것을 환영합니다!</p>
			<div class="col"></div>
			<div class="col">
				<a href="list-reservations" class="btn btn-custom btn-lg btn-secondary">예약하기</a>
			</div>
			<div class="col-3">
				<a href="chat-room" class="btn btn-custom btn-lg btn-secondary">문의하기</a>
			</div>
			<div class="col"></div>
		</div>
	</div>
</div>

<script src="webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script src="webjars/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
