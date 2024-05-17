<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
%>
<html>
<head>
    <title>Chat Room</title>
    <style>
        #chat {
            border: 2px solid #dedede;
            padding: 10px;
            margin: 10px 0;
            height: 300px;
            overflow-y: scroll;
        }

        #messageInput {
            width: 70%;
            padding: 10px;
            margin-top: 10px;
            margin-right: 10px;
            font-size: 16px;
        }

        #sendButton {
            width: 20%;
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<h2>Chat Room</h2>
<div id="chat"></div>
<input type="text" id="messageInput" placeholder="Write a message...">
<button id="sendButton">Send</button>

<script>
    var username = "<%= username %>";
    // var username = ${username};
    var ws = new WebSocket("ws://localhost:8080/ws/chat");

    ws.onopen = function () {
        ws.send(JSON.stringify({type: "ENTER", content: username + "님이 입장했습니다. 무엇을 도와드릴까요?"}));
    };

    // ws.onclose = function () {
    //     ws.send(JSON.stringify({type: "LEAVE", content: username + "님이 나갔습니다."}));
    // };

    window.onbeforeunload = function() {
        ws.send(JSON.stringify({type: "LEAVE", content: username + "님이 나갔습니다."}));
        ws.close(); // WebSocket 연결을 명시적으로 닫습니다.
    };

    ws.onmessage = function (event) {
        var message = JSON.parse(event.data);
        var chat = document.getElementById('chat');
        chat.innerHTML += '<div><b>' + message.username + ':</b> ' + message.content + '</div>';
        chat.scrollTop = chat.scrollHeight; // Scroll to the bottom
    };

    document.getElementById('sendButton').onclick = function () {
        var messageInput = document.getElementById('messageInput');
        ws.send(JSON.stringify({type: "MESSAGE", username: username, content: messageInput.value}));
        messageInput.value = ''; // Clear the input
    };
</script>
</body>
</html>
