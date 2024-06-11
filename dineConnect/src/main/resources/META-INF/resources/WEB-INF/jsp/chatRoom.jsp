<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Room</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        body {
            background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTp2k74JjxBFS0xi8b_HuH4TLewKbXRcUj-Ow&s');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container-custom {
            width: 600px; /* 고정된 크기 */
            padding: 25px;
            background-color: rgba(255, 255, 255, 0.8); /* 투명도 추가 */
            border-radius: 10px;
        }
        .container-custom h2 {
            text-align: left;
            padding: 5px 5px 5px 15px;
            color: #000000;
            border-left: 3px solid #000000;
            margin-bottom: 20px;
        }
        .roomContainer {
            background-color: #F6F6F6;
            width: 400px;
            margin: 0 auto;
            overflow: auto;
            border-radius: 10px;
        }
        .roomList th, .roomList td {
            border: none; /* 각 셀의 경계선을 없앰 */
            padding: 10px;
        }
        .roomList th {
            background-color: #fff;
            color: #000000;
            font-size: 18px;
        }
        .roomList td {
            background-color: #fff;
            text-align: left;
            color: #000000;
            font-size: 18px;
        }
        .roomList .num {
            width: 75px;
            text-align: center;
        }
        .roomList .room {
            width: 350px;
            text-align: center; /* 가운데 정렬 */
        }
        .roomList .go {
            width: 71px;
            text-align: center;
        }
        .roomList tr {
            border-bottom: 1px solid #ccc; /* 행 사이에 회색 선 추가 */
        }
        button {
            background-color: #FFFFFF;
            font-size: 14px;
            color: #000;
            border: 1px solid #000;
            border-radius: 5px;
            padding: 3px;
            margin: 3px;
        }
        .inputTable th {
            padding: 5px;
        }
        .inputTable input {
            width: 330px;
            height: 25px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<script type="text/javascript">
    var ws;
    window.onload = function(){
        getRoom();
        createRoom();
    }

    function getRoom(){
        commonAjax('/getRoom', "", 'post', function(result){
            createChatingRoom(result);
        });
    }

    function createRoom(){
        $("#createRoom").click(function(){
            var msg = { roomName : $('#roomName').val() };

            commonAjax('/createRoom', msg, 'post', function(result){
                createChatingRoom(result);
            });

            $("#roomName").val("");
        });
    }

    function goRoom(number, name){
        location.href="/moveChating?roomName="+name+"&"+"roomNumber="+number;
    }

    function createChatingRoom(res){
        if(res != null){
            var tag = "<tr>" +
                "<th class='room'>방 이름</th><th class='go'></th></tr>";
            res.forEach(function(d, idx){
                var rn = d.roomName.trim();
                var roomNumber = d.roomNumber;
                tag += "<tr>"+
                    "<td class='room'>"+ rn +"</td>"+
                    "<td class='go'><button type='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>" +
                    "</tr>";
            });
            $("#roomList").empty().append(tag);
        }
    }

    function commonAjax(url, parameter, type, calbak, contentType){
        $.ajax({
            url: url,
            data: parameter,
            type: type,
            contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (res) {
                calbak(res);
            },
            error : function(err){
                console.log('error');
                calbak(err);
            }
        });
    }

</script>
<body>
<%@ include file="common/navigation.jspf"%>
<div class="d-flex justify-content-center align-items-center vh-100">
    <div class="container-custom">
        <h2>채팅방</h2>
        <div id="roomContainer" class="roomContainer">
            <table id="roomList" class="roomList"></table>
        </div>
        <div>
            <table class="inputTable">
                <%--            <tr>--%>
                <%--                <th>방 제목</th>--%>
                <%--                <th><input type="text" name="roomName" id="roomName"></th>--%>
                <%--                <th><button id="createRoom">방 만들기</button></th>--%>
                <%--            </tr>--%>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
