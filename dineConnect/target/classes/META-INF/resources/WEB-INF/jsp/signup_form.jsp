<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-image: url('<%= request.getContextPath() %>/images/bar-826687_1280.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            overflow: hidden;
            position: relative;
        }
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6); /* 검은색 투명 레이어 */
            z-index: -1; /* 배경 위로 위치 */
        }

    </style>
</head>
<body>
<%@ include file="common/navigation.jspf"%>
<div class="d-flex justify-content-center align-items-center vh-100">
    <div class="container my-3 border p-4 rounded" style="max-width: 300px; background-color: rgba(255, 255, 255, 0.9); position: relative; z-index: 1;"> <!-- 컨테이너 위치 조정 -->
        <div class="my-3 border-bottom text-center">
            <h4>회원가입</h4>
        </div>
        <form:form action="/sign/signup" method="post" modelAttribute="signupForm">
            <div class="mb-3">
                <label for="username" class="form-label">사용자ID</label>
                <form:input path="username" type="text" class="form-control" id="username" />
            </div>
            <div class="mb-3">
                <label for="password1" class="form-label">비밀번호</label>
                <form:password path="password1" class="form-control" id="password1"/>
            </div>
            <div class="mb-3">
                <label for="password2" class="form-label">비밀번호 확인</label>
                <form:password path="password2" class="form-control" id="password2"/>
            </div>
            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-secondary">회원가입</button>
            </div>
        </form:form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
