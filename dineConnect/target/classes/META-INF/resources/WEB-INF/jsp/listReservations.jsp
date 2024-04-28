<!--JSTL tag  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!-- 예약하기(날짜) -->

<html>
<head>
<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet">
<title>List Reservation Page</title>
</head>
<body>
	<%@ include file="common/navigation.jspf" %>


	<div class="container">
	<form action="process" method="post">
        <% for (int i = 1; i <= 28; i++) { %>
            <button type="submit" name="button" value="<%= i %>"><%= i %></button>
        <% } %>
    </form>
		<table class="table">
			<thead>
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
			</thead>
			<tbody>
				<!--모든 reservations를 반복  -->
				<tr>
					<td><a href="select-time" class="btn btn-success">1</a></td>
					<td><button type="button">2</button></td>
					<td><button type="button">3</button></td>
					<td><button type="button">4</button></td>
					<td><button type="button">5</button></td>
					<td><button type="button">6</button></td>
					<td><button type="button">7</button></td>
				</tr>
				<tr>
					<td><button type="button">8</button></td>
					<td><button type="button">9</button></td>
					<td><button type="button">10</button></td>
					<td><button type="button">11</button></td>
					<td><button type="button">12</button></td>
					<td><button type="button">13</button></td>
					<td><button type="button">14</button></td>
				</tr>
				<tr>
					<td><button type="button">15</button></td>
					<td><button type="button">16</button></td>
					<td><button type="button">17</button></td>
					<td><button type="button">18</button></td>
					<td><button type="button">19</button></td>
					<td><button type="button">20</button></td>
					<td><button type="button">21</button></td>
				</tr>
				<tr>
					<td><button type="button">22</button></td>
					<td><button type="button">23</button></td>
					<td><button type="button">24</button></td>
					<td><button type="button">25</button></td>
					<td><button type="button">26</button></td>
					<td><button type="button">27</button></td>
					<td><button type="button">28</button></td>
				</tr>

			</tbody>
		</table>
	</div>
	<script src="webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
	<script src="webjars/jquery/3.6.0/jquery.min.js"></script>
</body>

</html>