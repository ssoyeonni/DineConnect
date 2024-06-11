<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTp2k74JjxBFS0xi8b_HuH4TLewKbXRcUj-Ow&s');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
    </style>
</head>
<body>
<%@ include file="common/navigation.jspf"%>
<div class="d-flex justify-content-center align-items-center vh-100">
    <div class="container my-3 border p-4 rounded" style="max-width: 300px; background-color: rgba(255, 255, 255, 0.9);">
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
