var resourcename = "status"


$(function() {
    function display(bool) {
        if (bool) {
            $("#wrapper").fadeIn(500);
            $('.laptop').fadeIn(500);
        } else {
            $("#wrapper").fadeOut(250);
            $('.laptop').fadeOut(250);

        }
    }

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                $("#title").html(`${item.name} | San Andreas`);
            } else {
                display(false)
            };
        };
        if (item.type === "nameResult") {
            NameResult(true)
            $("#name").html(item.name);
            $("#sex").html(item.sex);
            $("#height").html(item.height);
            $("#weight").html(item.weight);
            $("#license").html(item.license);
            $("#endorsements").html(item.endorsements);
        };
    })

    $("#statusoptions").click(function() {
        if ($("#statusmain").is(":hidden")) {
            if ($("#namecheckd").is(":visible")) {
                NameSearch(false)
            };
            NameSearch(false)
            $('#statusmain').fadeIn(500);
        } else {
            $('#statusmain').fadeOut(250);
        };
    })

    $("#namecheck").click(function() {
        if ($("#namecheckd").is(":hidden")) {
            if ($("#statusmain").is(":visible")) {
                $('#statusmain').fadeOut(250);
            };
            NameSearch(true)
        } else {
            $('#namecheckd').fadeOut(250);
        };
    })

    $("#search").click(function() {
        var firstname = $("#firstname").val() // Gets the value of the firstname input.
        var lastname = $("#lastname").val() // Gets the value of the lastname input.

        $.post('http://' + resourcename + '/search', JSON.stringify({
            firstname: firstname,
            lastname: lastname
        }));
    })

    $("#closesystem").click(function() {
        $.post('http://' + resourcename + '/closesystem');
        return
    })

    $("#105").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-5 - Meal Break Burger Shots Etc" }));
        return
    })

    $("#106").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-6 - Busy" }));
        return
    })

    $("#107").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-7 - Out of Service" }));
        return
    })

    $("#108").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-8 - In Service" }));
        return
    })

    $("#1011").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-11 - Traffic Stop" }));
        return
    })

    $("#1012").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-12 - Standby" }));
        return
    })

    $("#1023").click(function() {
        $.post('http://' + resourcename + '/setstatus', JSON.stringify({ status: "10-23 - Arrived on Scene" }));
        return
    })

    function NameSearch(bool) {
        if (bool) {
            $('#namesearch').fadeIn(500);
            $('#namecheckd').fadeIn(500);
            $('#namecheckresult').fadeOut(250);
        } else {
            $('#namesearch').fadeOut(250);
            $('#namecheckd').fadeOut(250);
            $('#namecheckresult').fadeOut(250);

        }
    }

    function NameResult(bool) {
        if (bool) {
            $('#namecheckresult').fadeIn(500);
        } else {
            $('#namecheckresult').fadeOut(250);

        }
    }

    function display(bool) {
        if (bool) {
            $("#maincontainer").fadeIn(500);
            $('.laptop').fadeIn(500);
        } else {
            $("#maincontainer").fadeOut(250);
            $('.laptop').fadeOut(250);

        }
    }

})

var elm = "maincontainer"

function scaleBasedOnWindow(elm, scale = 1, fit = false) {
    if (!fit) {
        elm.style.transform = 'scale(' + scale / Math.min(elm.clientWidth / window.innerWidth, elm.clientHeight / window.innerHeight) + ')';
    } else {
        elm.style.transform = 'scale(' + scale / Math.max(elm.clientWidth / window.innerWidth, elm.clientHeight / window.innerHeight) + ')';
    }
}