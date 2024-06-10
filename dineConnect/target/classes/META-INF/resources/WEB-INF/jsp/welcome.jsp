<!-- 홈 화면 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
	<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
	<title>Welcome Page</title>
	<style>
		.row {
			position: relative;
		}
		.col {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 450px;
			overflow: hidden;
			border-radius: 5px;
		}
		.col img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			margin-left: -40px;
		}
		.col-right {
			display: flex;
			justify-content: center;
			align-items: center;
			flex-direction: column;
			text-align: center;
			font-family: "Nunito", sans-serif;
		}
	</style>
</head>
<body>
<%@ include file="common/navigation.jspf"%>
<div class="container">
	<div class="row">
		<div class="col ">
			<img src="https://png.pngtree.com/thumb_back/fh260/background/20210906/pngtree-western-food-daytime-food-and-gourmet-photography-photography-map-with-pictures-image_803946.jpg" class="rounded float-start" alt="음식">
		</div>
		<div class="col col-right border border-bottom border-top">
			<p class="fw-bold fs-2">Dine-Connect에 오신 것을 환영합니다!</p>
			<p></p>
			<p class="lh-base">Dine-Connect는 미식가들을 위한 최고의 만남의 장소입니다.
				저희는 다양한 세계 요리를 한자리에서 맛볼 수 있는 특별한 경험을 제공합니다.
				신선한 재료와 창의적인 요리법으로 완성된 메뉴는 고객님의 입맛을 사로잡을 것입니다.
				</p>
			<p class="lh-base">Dine-Connect에서 특별한 미식 여행을 떠나보세요.
				여러분의 방문을 기다리고 있겠습니다.</p>
			<a href="list-reservations" class="btn btn-outline-success btn-lg">예약하기</a>
		</div>
	</div>

	<div>
		<a href="list-reservations">예약하기</a>
	</div>
	<div>
		<a href="chat-room">상담</a>
	</div>

	<script src="webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
	<script src="webjars/jquery/3.6.0/jquery.min.js"></script>
</div>
</body>
</html>
