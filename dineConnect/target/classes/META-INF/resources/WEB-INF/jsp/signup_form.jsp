<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
<div class="container my-3">
    <div class="my-3 border-bottom">
        <h4>회원가입</h4>
    </div>
    <form:form action="/sign/signup" method="post" modelAttribute="signupForm">
        <div class="mb-3">
            <label for="username" class="form-label">사용자ID</label>
            <form:input path="username" type="text" class="form-control" id="username"/>
        </div>
        <div class="mb-3">
            <label for="password1" class="form-label">비밀번호</label>
            <form:password path="password1" class="form-control" id="password1"/>
        </div>
        <div class="mb-3">
            <label for="password2" class="form-label">비밀번호 확인</label>
            <form:password path="password2" class="form-control" id="password2"/>
        </div>
        <button type="submit" class="btn btn-primary">회원가입</button>
    </form:form>
</div>
</body>
</html>
