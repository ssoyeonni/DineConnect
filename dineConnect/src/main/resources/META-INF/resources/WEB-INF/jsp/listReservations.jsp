<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <title>List Reservation Page</title>
    <style>
        body {
            background-image: url('<%= request.getContextPath() %>/images/bar-826687_1280.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }

        .navbar {
            width: 100%;
            background: rgba(0, 0, 0, 0.8);
            position: absolute;
            top: 0;
            left: 0;
            z-index: 2;
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
        }

        .container {
            position: relative;
            z-index: 3;
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            color: black;
            max-width: 800px;
            width: 100%;
            margin-top: 60px;
        }

        .timeSelectBtn {
            background-color: #000;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .timeSelectBtn[disabled] {
            background-color: #555;
            opacity: 0.5;
        }

        #reservationForm {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="overlay"></div>
<div class="navbar">
    <%@ include file="common/navigation.jspf" %>
</div>

<div class="container">
    <form id="reservationForm" action="submit" method="post">
        <input type="text" id="selectedDate" name="selectedDate" class="form-control mb-3" />
        <input type="hidden" name="username" value="${name}" />
        <input type="hidden" id="selectedTime" name="selectedTime" />
        <button type="submit" class="btn btn-primary">예약하기</button>
    </form>

    <div class="container mt-3" id="timeButtonContainer">
        <table class="table">
            <thead>
            <tr>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><button type="button" class="timeSelectBtn" data-time="09:00">09:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="10:00">10:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="11:00">11:00</button></td>
            </tr>
            <tr>
                <td><button type="button" class="timeSelectBtn" data-time="12:00">12:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="13:00">13:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="14:00">14:00</button></td>
            </tr>
            <tr>
                <td><button type="button" class="timeSelectBtn" data-time="17:00">17:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="18:00">18:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="19:00">19:00</button></td>
                <td><button type="button" class="timeSelectBtn" data-time="20:00">20:00</button></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script src="webjars/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<script>
    $(function() {
        var selectedDate = null;
        // 달력
        $('#selectedDate').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            minDate: moment(),
            locale: {
                format: 'YYYY-MM-DD'
            },
            drops: 'down', // 드롭다운이 항상 아래로 열리도록 설정
            opens: 'center'
        }, function(start, end, label) {
            selectedDate = start.format('YYYY-MM-DD');
            $('#timeButtonContainer').show();
            resetTimeButtons();
            loadDisabledTimes(selectedDate);
        });

        $('table').on('click', 'button.timeSelectBtn', function() {
            var selectedTime = $(this).data('time');
            $('#selectedTime').val(selectedTime);
            $(this).prop('disabled', true);
            $(this).css('opacity', '0.5'); // 블러 처리
        });

        $('#reservationForm').submit(function(event) {
            event.preventDefault(); // 페이지 리로드 방지
            var date = $('#selectedDate').val();
            var time = $('#selectedTime').val();
            var username = $('input[name="username"]').val();

            if (date && time) {
                $.ajax({
                    url: '/submit',
                    method: 'POST',
                    data: {
                        username: username,
                        selectedDate: date,
                        selectedTime: time
                    },
                    success: function(response) {
                        alert(response); // 팝업 메시지 표시
                    },
                    error: function(xhr) {
                        alert(xhr.responseText);
                    }
                });
            } else {
                alert("날짜와 시간을 선택해주세요.");
            }
        });

        function loadDisabledTimes(selectedDate) {
            $.ajax({
                url: '/get-disabled-times',
                method: 'GET',
                data: { date: selectedDate },
                success: function(response) {
                    response.disabledTimes.forEach(function(time) {
                        $('button.timeSelectBtn[data-time="' + time + '"]').prop('disabled', true).css('opacity', '0.5');
                    });
                }
            });
        }

        function resetTimeButtons() {
            $('button.timeSelectBtn').prop('disabled', false).css('opacity', '1');
            $('#selectedTime').val('');
        }
    });
</script>
</body>
</html>
