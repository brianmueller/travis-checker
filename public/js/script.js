$(function() {
    var clipboard = new Clipboard('.btn');

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
        $(this).html("Copied!");
    });
    $('#copy').blur(function() {
        $(this).html("Copy");
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
            $('#grades').append($('#student' + i + 'grade').text()+"<br>");
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
