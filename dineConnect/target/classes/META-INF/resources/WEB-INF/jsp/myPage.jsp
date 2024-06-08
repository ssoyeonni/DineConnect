<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<title>My Page</title>
</head>
<body>
    <%@ include file="common/navigation.jspf"%>
    <div class="container">
        <h1>My Page</h1>
        <hr>
        <h2>예약 확인</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>날짜</th>
                    <th>시간</th>
                    <th>취소</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="reservation" items="${reservations}">
                    <tr>
                        <td>${reservation.date}</td>
                        <td>${reservation.time}</td>
                        <td>
                            <button type="button" class="btn btn-danger cancel-reservation-btn" data-id="${reservation.id}">취소</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <script src="webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
        <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                $('.cancel-reservation-btn').click(function() {
                    var reservationId = $(this).data('id');
                    if (confirm("정말로 이 예약을 취소하시겠습니까?")) {
                        $.ajax({
                            url: '/cancel-reservation',
                            method: 'POST',
                            data: { id: reservationId },
                            success: function(response) {
                                alert(response);
                                location.reload(); // Reload the page to update the state
                            },
                            error: function(xhr) {
                                alert("예약 취소 중 오류가 발생했습니다. 다시 시도해주세요.");
                            }
                        });
                    }
                });
            });
        </script>
    </div>
</body>
</html>
