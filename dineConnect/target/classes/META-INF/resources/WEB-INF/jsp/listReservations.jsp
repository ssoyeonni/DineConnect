<!--JSTL tag  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!-- 예약하기(날짜) -->

<html>
	<head>
		<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css"
			rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
		<!-- DateRangePicker CSS 사용 -->
		<title>List Reservation Page</title>
	</head>
	<body>
		<%@ include file="common/navigation.jspf" %>


		<div class="container">
		<form action="process" method="post">
<%--        <% for (int i = 1; i <= 28; i++) { %>--%>
<%--            <button type="submit" name="button" value="<%= i %>"><%= i %></button>--%>
<%--        <% } %>--%>
			<input type="text" id="selectedDate" name="selectedDate"/>
    	</form>
			<div class="container" style="display:none" id="timeButtonContainer">
				<table class="table">
					<thead>
						<tr>
						</tr>
					</thead>
					<tbody>
					<!--모든 reservations를 반복  -->
					<tr>
						<td><a href="select-time" class="btn btn-success">09:00</a></td>

						<td><button type="button" class="timeSelectBtn">10:00</button></td>
						<td><button type="button" class="timeSelectBtn">11:00</button></td>
					</tr>
					<tr>
						<td><button type="button" class="timeSelectBtn">12:00</button></td>
						<td><button type="button" class="timeSelectBtn">13:00</button></td>
						<td><button type="button" class="timeSelectBtn">14:00</button></td>
					</tr>
					<tr>
						<td><button type="button" class="timeSelectBtn">17:00</button></td>
						<td><button type="button" class="timeSelectBtn">18:00</button></td>
						<td><button type="button"class="timeSelectBtn">19:00</button></td>
						<td><button type="button" class="timeSelectBtn">20:00</button></td>
					</tr>
					<tr>
						<form action="submit" method="get">
							<input type="hidden" name="username" value="">
							<button type="submit">예약하기</button>
						</form>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
		<script src="webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
		<script src="webjars/jquery/3.6.0/jquery.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

		<!-- 날짜 선택 -->
		<script>
			$(function() {
				$('#selectedDate').daterangepicker({
					singleDatePicker: true,
					showDropdowns: true,
					minDate: moment(),
					maxYear: parseInt(moment().format('YYYY'),1),
					locale: {
						format: 'YYYY-MM-DD' // 날짜 형식 설정
					}
				},  function(start, end, label) {
					console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
					$('#timeButtonContainer').show();
				});
				$('table').on('click', 'button.timeSelectBtn', function() {
					// 시간 선택 로직 구현
					// 예: 모달을 열어 사용자가 시간을 선택하게 함
				});
			});
		</script>

	</body>

</html>