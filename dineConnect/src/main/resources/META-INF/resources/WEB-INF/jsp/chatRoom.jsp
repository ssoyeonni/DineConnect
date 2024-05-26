<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<html>
    <head>
        <title>chat</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
        <meta charset="UTF-8">
        <style>
            .chatting{
                background-color: #000;
                width: 500px;
                height: 500px;
                overflow: auto;
            }
            .chatting p{
                color: #fff;
                text-align: left;
            }
            #yourMsg{
                display: none;
            }
        </style>
    </head>
    <body>
    <script type="text/javascript">
        var ws;
        var username = "${username}";

        function wsOpen(){
            ws = new WebSocket("ws://" + location.host + "/chatting");
            wsEvt();
            // 웹소켓 연결 시 사용자 이름을 설정하고 등록 버튼을 숨깁니다.
            if(username != null && username.trim() != ""){
                $("#yourName").hide();
                $("#yourMsg").show();
            } else {
                $("#yourName").show();
                $("#yourMsg").hide();
            }
        }

        function wsEvt() {
            ws.onopen = function(data){
                //소켓이 열리면 초기화 세팅하기
            }

            ws.onmessage = function(data) {
                var msg = data.data;
                if(msg != null && msg.trim() != ''){
                    $("#chating").append("<p>" + msg + "</p>");
                }
            }

            document.addEventListener("keypress", function(e){
                if(e.keyCode == 13){ //enter press
                    send();
                }
            });
        }

        function chatName(){
            var userName = $("#userName").val();
            if(userName == null || userName.trim() == ""){
                alert("사용자 이름을 입력해주세요.");
                $("#userName").focus();
            }else{
                wsOpen();
                $("#yourName").hide();
                $("#yourMsg").show();
            }
        }

        function send() {
            var msg = $("#chatting").val();
            ws.send(username+" : "+msg); // 사용자 이름을 입력 필드에서 가져오는 대신, 모델에서 받은 username을 사용
            $('#chatting').val("");
        }
        $(document).ready(function() {
            // 페이지 로드 시 사용자 이름이 설정되어 있으면 웹소켓 연결을 시작합니다.
            if(username != null && username.trim() != ""){
                wsOpen();
            }
        });
    </script>
    <body>
    <div id="container" class="container">
        <h1>채팅</h1>
        <div>${username}님 무엇을 도와드릴까요?</div>
        <div id="chating" class="chating">
        </div>

<%--        <div id="yourName">--%>
<%--            <table>--%>
<%--                <tr>--%>
<%--                    <th>닉네임</th>--%>
<%--                    <th><input class="form-control form-control-sm" type="text" name="userName" id="userName"></th>--%>
<%--                    <th><button class="btn btn-sm btn-primary" onclick="chatName()" id="startBtn">등록</button></th>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--        </div>--%>
        <div id="yourMsg">
            <table>
                <tr>
                    <th>메시지</th>
                    <th><input class="form-control form-control-sm" id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                    <th><button class="btn btn-sm btn-primary" onclick="send()" id="sendBtn">보내기</button></th>
                </tr>
            </table>
        </div>
    </div>
    </body>
</html>