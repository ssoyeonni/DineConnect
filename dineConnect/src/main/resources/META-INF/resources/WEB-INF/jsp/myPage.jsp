<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <title>My Page</title>
    <style>
        body {
            background-image: url('<%= request.getContextPath() %>/images/bar-826687_1280.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;

            z-index: 0;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6); /* 어두운 오버레이 */
            z-index: 1;
        }

        .navbar {
            width: 100%;
            background: rgba(0, 0, 0, 0.8);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 2;
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
        }

        .container {
            position: relative;
            z-index: 3;
            background: rgba(255, 255, 255, 0.8); /* 반투명 흰색 배경 */
            padding: 20px;
            border-radius: 10px;
            color: black;
            max-width: 800px;
            width: 100%;
            margin-top: 300px; /* 네비게이션 바 아래에 위치하도록 마진 설정 */
        }


    </style>
</head>

<body>
<div class="overlay"></div>
<div class="navbar">
    <%@ include file="common/navigation.jspf"%>
</div>

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
                if (confirm("예약을 취소하시겠습니까?")) {
                    $.ajax({
                        url: '/cancel-reservation',
                        method: 'POST',
                        data: { id: reservationId },
                        success: function(response) {
                            alert(response);
                            location.reload();
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
