$(function() {
    var clipboard = new Clipboard('#copy');

    clipboard.on('success', function(e) {
        console.info('Action:', e.action);
        console.info('Text:', e.text);
        console.info('Trigger:', e.trigger);

        e.clearSelection();
    });

    clipboard.on('error', function(e) {
        console.error('Action:', e.action);
        console.error('Trigger:', e.trigger);
    });

    $('#copy').click(function() {
        $(this).html("DONE");
    });
    $('#copy').blur(function() {
        $(this).html("COPY");
    });

    function datePickerNow() {
        var now = new Date();
        $('#datePicker').val(now.getFullYear() + "-" + ("0" + (now.getMonth() + 1)).slice(-2) + "-" + ("0" + now.getDate()).slice(-2) + "T" + now.getHours() + ":" + now.getMinutes());
    }
    datePickerNow();

    function convertToLocal() {
        var times = document.getElementsByClassName("time");
        for (var i = 0; i < times.length; i++) {
            var localDate = new Date($('#student' + i + 'time').text()).toString();
            if (localDate != "Invalid Date") {
                $('#student' + i + 'time').text(localDate);
            }
        }
    }
    convertToLocal();

    function detectLatenesses(deadline) {
        var times = document.getElementsByClassName("time");
        for (var i = 0; i < times.length; i++) {
            if (Date.parse($('#student' + i + 'time').text()) > deadline) {
                $('#student' + i + 'time').css("color", "red");
                $('#student' + i + 'grade').text(parseInt($('#student' + i + 'grade').text()) / 2);
            }
            else {
                $('#student' + i + 'time').css("color", "black");
            }
        }
    }

    $('#detectLatenesses').click(function() {
        detectLatenesses(Date.parse($('#datePicker').val()));
    });

    function updateGrades() {
        var statuses = document.getElementsByClassName("status");
        var grades = document.getElementsByClassName("grade")
        for (var i = 0; i < grades.length; i++) {
            if (statuses[i].text == "success") {
                $('#student' + i + 'grade').text(10);
            }
            else if (statuses[i].text == "failure") {
                $('#student' + i + 'grade').text(6);
            }
            else {
                $('#student' + i + 'grade').text(0);
            }
        }
    }

    function transferGrades() {
        $('#grades').html("");
        var grades = document.getElementsByClassName("grade");
        for (var i = 0; i < grades.length; i++) {
            $('#grades').append($('#student' + i + 'grade').text() + "<br>");
        }
    }

    updateGrades();
    transferGrades();

    $('.grade').click(
        function() {
            var grade = prompt("What would you like to make the new grade?")
            $(this).text(grade);
            transferGrades();
        });
    $('#reset').click(
        function() {
            updateGrades();
            transferGrades();
        });

});
