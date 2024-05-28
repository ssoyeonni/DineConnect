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
<script type="text/javascript">
    var ws;
    var username = "${username}";
    <%--var roomNumber = "${roomNumber}";--%>


    function wsOpen(){
        //웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
        // ws = new WebSocket("ws://" + location.host + "/chating/"+roomNumber);
        ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
        console.log("wsOpen");
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
            // 메시지 받으면 동작
            var msg = data.data;
            if(msg != null && msg.trim() != ''){
                var d = JSON.parse(msg);
                if(d.type == "getId"){
                    var si = d.sessionId != null ? d.sessionId : "";
                    if(si != ''){
                        $("#sessionId").val(si);
                    }
                }else if(d.type == "message"){
                    if(d.sessionId == $("#sessionId").val()){
                        $("#chating").append("<p class='me'>"+username+": " + d.msg + "</p>");
                        // 세션 아이디 별로 username 다르게 나와야하는데 다른 아이디에서 보내도 내 아이디가 나옴.
                    }else{
                        $("#chating").append("<p class='others'>" + d.userName + ": " + d.msg + "</p>");
                    }

                }else{
                    console.warn("unknown type!")
                }
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
            username = userName;
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }
    }

    function send() {
        // var msg = $("#chatting").val();
        // ws.send(username+" : "+msg); // 사용자 이름을 입력 필드에서 가져오는 대신, 모델에서 받은 username을 사용
        // $('#chatting').val("");
        // JSON 형태로 발신
        console.log("send");
        var option ={
            type: "message",
            roomNumber:  $("#roomNumber").val(),
            sessionId : $("#sessionId").val(),
            userName : username,
            msg : $("#chatting").val()
        }
        ws.send(JSON.stringify(option))
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
<%--    <h1>채팅</h1>--%>
<%--    <h1>${roomName}의 채팅방</h1>--%>
<%--    <div>${username}님 무엇을 도와드릴까요?</div>--%>
<%--    <div id="chating" class="chating">--%>
<%--        --%>
<%--    </div>--%>
    <h1>${roomName}</h1>
    <div>${username}님 무엇을 도와드릴까요?</div>
    <input type="hidden" id="sessionId" value="">
    <input type="hidden" id="roomNumber" value="${roomNumber}">

    <div id="chating" class="chating">
    </div>


    <div id="yourName">
        <table>
            <tr>
                <th>닉네임</th>
                <th><input class="form-control form-control-sm" type="text" name="userName" id="userName"></th>
                <th><button class="btn btn-sm btn-primary" onclick="chatName()" id="startBtn">등록</button></th>
            </tr>
        </table>
    </div>
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

<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
<%--         pageEncoding="UTF-8"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Chating</title>--%>
<%--    <style>--%>
<%--        *{--%>
<%--            margin:0;--%>
<%--            padding:0;--%>
<%--        }--%>
<%--        .container{--%>
<%--            width: 500px;--%>
<%--            margin: 0 auto;--%>
<%--            padding: 25px--%>
<%--        }--%>
<%--        .container h1{--%>
<%--            text-align: left;--%>
<%--            padding: 5px 5px 5px 15px;--%>
<%--            color: #FFBB00;--%>
<%--            border-left: 3px solid #FFBB00;--%>
<%--            margin-bottom: 20px;--%>
<%--        }--%>
<%--        .chating{--%>
<%--            background-color: #000;--%>
<%--            width: 500px;--%>
<%--            height: 500px;--%>
<%--            overflow: auto;--%>
<%--        }--%>
<%--        .chating .me{--%>
<%--            color: #F6F6F6;--%>
<%--            text-align: right;--%>
<%--        }--%>
<%--        .chating .others{--%>
<%--            color: #FFE400;--%>
<%--            text-align: left;--%>
<%--        }--%>
<%--        input{--%>
<%--            width: 330px;--%>
<%--            height: 25px;--%>
<%--        }--%>
<%--        #yourMsg{--%>
<%--            display: none;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>

<%--<script type="text/javascript">--%>
<%--    var ws;--%>

<%--    function wsOpen(){--%>
<%--        //웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.--%>
<%--        ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());--%>
<%--        wsEvt();--%>
<%--    }--%>

<%--    function wsEvt() {--%>
<%--        ws.onopen = function(data){--%>
<%--            //소켓이 열리면 동작--%>
<%--        }--%>

<%--        ws.onmessage = function(data) {--%>
<%--            //메시지를 받으면 동작--%>
<%--            var msg = data.data;--%>
<%--            if(msg != null && msg.trim() != ''){--%>
<%--                var d = JSON.parse(msg);--%>
<%--                if(d.type == "getId"){--%>
<%--                    var si = d.sessionId != null ? d.sessionId : "";--%>
<%--                    if(si != ''){--%>
<%--                        $("#sessionId").val(si);--%>
<%--                    }--%>
<%--                }else if(d.type == "message"){--%>
<%--                    if(d.sessionId == $("#sessionId").val()){--%>
<%--                        $("#chating").append("<p class='me'>나 :" + d.msg + "</p>");--%>
<%--                    }else{--%>
<%--                        $("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");--%>
<%--                    }--%>

<%--                }else{--%>
<%--                    console.warn("unknown type!")--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>

<%--        document.addEventListener("keypress", function(e){--%>
<%--            if(e.keyCode == 13){ //enter press--%>
<%--                send();--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>

<%--    function chatName(){--%>
<%--        var userName = $("#userName").val();--%>
<%--        if(userName == null || userName.trim() == ""){--%>
<%--            alert("사용자 이름을 입력해주세요.");--%>
<%--            $("#userName").focus();--%>
<%--        }else{--%>
<%--            wsOpen();--%>
<%--            $("#yourName").hide();--%>
<%--            $("#yourMsg").show();--%>
<%--        }--%>
<%--    }--%>

<%--    function send() {--%>
<%--        var option ={--%>
<%--            type: "message",--%>
<%--            roomNumber: $("#roomNumber").val(),--%>
<%--            sessionId : $("#sessionId").val(),--%>
<%--            userName : $("#userName").val(),--%>
<%--            msg : $("#chatting").val()--%>
<%--        }--%>
<%--        ws.send(JSON.stringify(option))--%>
<%--        $('#chatting').val("");--%>
<%--    }--%>
<%--</script>--%>
<%--<body>--%>
<%--<div id="container" class="container">--%>
<%--    <h1>${roomName}의 채팅방</h1>--%>
<%--    <input type="hidden" id="sessionId" value="">--%>
<%--    <input type="hidden" id="roomNumber" value="${roomNumber}">--%>

<%--    <div id="chating" class="chating">--%>
<%--    </div>--%>

<%--    <div id="yourName">--%>
<%--        <table class="inputTable">--%>
<%--            <tr>--%>
<%--                <th>사용자명</th>--%>
<%--                <th><input type="text" name="userName" id="userName"></th>--%>
<%--                <th><button onclick="chatName()" id="startBtn">이름 등록</button></th>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </div>--%>
<%--    <div id="yourMsg">--%>
<%--        <table class="inputTable">--%>
<%--            <tr>--%>
<%--                <th>메시지</th>--%>
<%--                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>--%>
<%--                <th><button onclick="send()" id="sendBtn">보내기</button></th>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>