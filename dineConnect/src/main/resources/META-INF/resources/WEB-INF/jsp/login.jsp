<!--  
<html>
	<head>
	<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
		<title>Login Page</title>
	</head>
	<body>
		<div class="container">
			Welcome to the login page!
			
			<pre>${errorMessage}</pre>
			<form method="post">
				Name: <input type="text" name="name">
				Password: <input type="password" name="password">
				<input type="submit">
			</form>
			
			
			
			
		</div>
		
	</body>
	
</html>
-->
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
<a href="/signup">회원가입</a>
</body>
</html>
