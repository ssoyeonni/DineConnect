<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>chat</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <style>
        body {
            background-image: url('<%= request.getContextPath() %>/images/bar-826687_1280.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
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
        .chatting {
            background-color: #F6F6F6;
            width: 500px;
            height: 500px;
            overflow-y: auto;
            padding: 10px;
            border-radius: 10px 10px 0px 0px;
            color: #000;
            display: flex;
            flex-direction: column;
            margin: 0 auto;
        }

        .chatting .message {
            margin: 10px 0; /* 메시지 사이의 간격 추가 */
            max-width: 200px; /* 메시지 말풍선의 최대 너비 설정 */
        }

        .chatting p {
            margin: 5px 0;
            padding: 10px;
            border-radius: 15px;
            display: inline-block;
            word-break: break-word;
            text-align: left;
        }

        #what {
            margin: 0 auto;
            font-size: 18px;
            text-align: center;

        }

        .me {
            align-self: flex-end;
            background-color: #c4ecff;
            text-align: right;
            padding: 7px;
            border-radius: 5px;
        }

        .others {
            align-self: flex-start;
            background-color: #FFFFFF;
            text-align: left;
            padding: 5px;
            border-radius: 5px;
        }

        #yourMsg {
            display: none;
        }

        .chat-input-container {
            width: 500px;  /* 채팅 입력창의 전체 너비를 500px로 설정 */
            padding: 15px;
            margin: 0 auto;
            background-color: #F6F6F6;
            border-radius: 0px 0px 5px 5px;
        }

        .input-group-append {
            display: flex;
        }

    </style>
</head>
<script type="text/javascript">
    var ws;
    var username = "${username}";

    function wsOpen() {
        ws = new WebSocket("ws://" + location.host + "/chating/" + $("#roomNumber").val());
        console.log("wsOpen");
        wsEvt();
        if (username != null && username.trim() != "") {
            $("#yourName").hide();
            $("#yourMsg").show();
        } else {
            $("#yourName").show();
            $("#yourMsg").hide();
        }
    }

    function wsEvt() {
        ws.onopen = function(data) {}

        ws.onmessage = function(data) {
            var msg = data.data;
            if (msg != null && msg.trim() != '') {
                var d = JSON.parse(msg);
                if (d.type == "getId") {
                    var si = d.sessionId != null ? d.sessionId : "";
                    if (si != '') {
                        $("#sessionId").val(si);
                    }
                } else if (d.type == "message") {
                    if (d.sessionId == $("#sessionId").val()) {
                        // $("#chating").append("<div class='message me'>" + username + ": " + d.msg + "</div>");
                        $("#chating").append("<div class='message me'>" + d.msg + "</div>");
                    } else {
                        $("#chating").append("<div class='message others'>" + d.userName + ": " + d.msg + "</div>");
                    }
                    $('#chating').scrollTop($('#chating')[0].scrollHeight);
                } else {
                    console.warn("unknown type!")
                }
                $("#chating").scrollTop($("#chating")[0].scrollHeight);
            }
        }

        document.addEventListener("keypress", function(e) {
            if (e.keyCode == 13) { //enter press
                send();
            }
        });
    }

    function chatName() {
        var userName = $("#userName").val();
        if (userName == null || userName.trim() == "") {
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        } else {
            username = userName;
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }
    }

    function send() {
        var option = {
            type: "message",
            roomNumber: $("#roomNumber").val(),
            sessionId: $("#sessionId").val(),
            userName: username,
            msg: $("#chatting").val()
        }
        ws.send(JSON.stringify(option))
        $('#chatting').val("");
    }

    $(document).ready(function() {
        if (username != null && username.trim() != "") {
            wsOpen();
        }
    });
</script>
<body>
<%@ include file="common/navigation.jspf"%>
<div id="container" class="container" style="position: relative; max-width: 520px; margin: 0 auto;">
<%--    <h1>${roomName}</h1>--%>
    <%--    <div>${username}님 무엇을 도와드릴까요?</div>--%>
    <div id ="what" style="color : #F6F6F6;">무엇을 도와드릴까요?</div>
    <input type="hidden" id="sessionId" value="">
    <input type="hidden" id="roomNumber" value="${roomNumber}">

    <div id="chating" class="chatting"></div>

    <div id="yourName">
        <table>
            <tr>
                <th>닉네임</th>
                <th><input class="form-control form-control-sm" type="text" name="userName" id="userName"></th>
                <th><button class="btn btn-sm btn-primary" onclick="chatName()" id="startBtn">등록</button></th>
            </tr>
        </table>
    </div>
    <div id="yourMsg" class="chat-input-container">
        <div class="input-group">
            <input type="text" class="form-control" id="chatting" placeholder="보내실 메시지를 입력하세요.">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" onclick="send()" id="sendBtn">보내기</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
