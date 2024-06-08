<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<h1>로그인</h1>
<form method="post" action="/login">
    <label for="username">사용자 이름:</label>
    <input type="text" id="username" name="username" required>
    <br>
    <label for="password">비밀번호:</label>
    <input type="password" id="password" name="password" required>
    <br>
    <button type="submit">로그인</button>
</form>
<a href="/sign/signup">회원가입</a>
</body>
</html>
