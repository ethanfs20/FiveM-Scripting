var resourcename = "core_mainmenu"

var slideCount = document.querySelectorAll('.slider .slide-item').length;
var slideWidth = document.querySelectorAll('.slider-outer')[0].offsetWidth;
var slideHeight = document.querySelectorAll(".slider-outer")[0].offsetHeight;

var sliderUlWidth = slideCount * slideWidth;
document.querySelectorAll('.slider')[0].style.cssText = "width:" + sliderUlWidth + "px";

for (var i = 0; i < slideCount; i++) {
    document.querySelectorAll('.slide-item')[i].style.cssText = "width:" + slideWidth + "px;height:" + slideHeight + "px";
}

setInterval(function() {
    moveRight();
}, 10000);
var counter = 1;

function moveRight() {
    var slideNum = counter++
        if (slideNum < slideCount) {
            var transformSize = slideWidth * slideNum;
            document.querySelectorAll('.slider')[0].style.cssText =
                "width:" + sliderUlWidth + "px; -webkit-transition:all 800ms ease; -webkit-transform:translate3d(-" + transformSize + "px, 0px, 0px);-moz-transition:all 800ms ease; -moz-transform:translate3d(-" + transformSize + "px, 0px, 0px);-o-transition:all 800ms ease; -o-transform:translate3d(-" + transformSize + "px, 0px, 0px);transition:all 800ms ease; transform:translate3d(-" + transformSize + "px, 0px, 0px)";

        } else {
            counter = 1;
            document.querySelectorAll('.slider')[0].style.cssText = "width:" + sliderUlWidth + "px;-webkit-transition:all 800ms ease; -webkit-transform:translate3d(0px, 0px, 0px);-moz-transition:all 800ms ease; -moz-transform:translate3d(0px, 0px, 0px);-o-transition:all 800ms ease; -o-transform:translate3d(0px, 0px, 0px);transition:all 800ms ease; transform:translate3d(0px, 0px, 0px)";
        }

}

window.onload = function(e) {
    window.addEventListener('message', function(event) {
        switch (event.data.action) {
            case 'senddata':
                DisplayUI(event.data);
                break;
            case 'pinfo':
                $("#pname").html(event.data.pname);
                $("#sid").html(event.data.sid);
                break;
        }
    })
};

$(document).ready(function() {
    $("#load").click(function() {
        charcont()
    });
    $("#info").click(function() {
        infocont()
    });

    $("#playchar").click(function() {
        var charid = $('.active-char').attr("data-charid")
        if (($('.active-char').attr("data-ischar") == "false")) {
            identity()
        } else {
            ShutdownUI()
            $.post("https://" + resourcename + "/CharacterChosen", JSON.stringify({
                charid: charid
            }));
        }
    });

    $("#deletechar").click(function() {
        $.post("https://" + resourcename + "/DeleteCharacter", JSON.stringify({
            charid: $('.active-char').attr("data-charid"),
        }));
        $(".character-box").removeClass('active-char');
        $("#delete").css({ "display": "none" });
        $(".character-buttons").hide();
        $(".character-box").html('<h3 class="character-fullname"><i class="fas fa-plus"></i></h3><div class="character-info"><p class="chartitle">Create new character</p></div>').attr("data-ischar", "false");

    });

    $("#exit").click(function() {
        $.post("https://" + resourcename + "/Disconnect");
    });
});

//when the user clicks on the submit button, it will run
$("#createchar").click(function() {
    let error = false
    let firstname = $("#firstname").val() // Gets the value of the firstname input.
    let lastname = $("#lastname").val() // Gets the value of the lastname input.
    let dob = $("#dob").val() // Gets the value of the dob input.
    let sex = $("#sex").val() // Gets the value of the sex input.
    let height = $("#height").val() // Gets the value of the height input.
    let weight = $("#weight").val() // Gets the value of the weight input.
    let desc = $("#desc").val() // Gets the value of the weight input.
    let attr = $("#attr").val() // Gets the value of the weight input.
    let license = "EXPIRED | INVALID"
    let m = ""
    let cdl = ""


    let licensecheck = document.getElementById("license");
    if (licensecheck.checked == true) {
        license = "VALID"
    };
    let mcheck = document.getElementById("motorcycle");
    if (mcheck.checked == true) {
        m = "M"
    };
    let cdlcheck = document.getElementById("cdl");
    if (cdlcheck.checked == true) {
        cdl = "CDL"
    };

    // if there are no errors from above, we can send the data back to the original callback and handle it from there
    $.post("https://" + resourcename + "/newidentity", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
        firstname: firstname,
        lastname: lastname,
        dateofbirth: dob,
        dob: dob,
        sex: sex,
        height: height,
        weight: weight,
        desc: desc,
        attr: attr,
        license: license,
        m: m,
        cdl: cdl
    }));;
    ShutdownUI();
})

function CheckIdent() {

    //this handles checking the firstname for errors.
    if (firstname.length >= 11) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Firstname needs to be equal/less than 10 characters!"
        }))

    } else if (!firstname) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Please input a firstname!"
        }))

    };
    // this handles checking the lastname input for errors
    if (lastname.length >= 11) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Lastname needs to be equal/less than 10 characters!"
        }))

    } else if (!lastname) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Please input a lastname!"
        }))

    };
    // this handles checking the dob for errors.
    if (dob.length >= 11) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Incorrect format for DOB! 12/34/5678 or 12-34-5678"
        }))

    } else if (!dob) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Please input a date of birth!"
        }))

    };

    if (sex.length >= 11) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Sex needs to be equal/less than 10 characters!"
        }))

    } else if (!sex) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Please input a sex!"
        }))

    };

    if (height.length >= 11) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Incorrect format for height! 12/34/5678 or 12-34-5678"
        }))

    } else if (!height) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Please input a date of birth!"
        }))

    };

    if (weight.length >= 11) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Incorrect format for weight! 12/34/5678 or 12-34-5678"
        }))

    } else if (!weight) {
        $.post("https://" + resourcename + "/error", JSON.stringify({
            error: "Please input a date of birth!"
        }))

    };
};

$(".character-box").click(function() {
    $(".character-box").removeClass('active-char', 1000, "easeInBack");
    $(this).addClass('active-char');
    $(".character-buttons").fadeIn(500);
    if ($(this).attr("data-ischar") === "true") {
        $("#delete").fadeIn(500);
    } else {
        $("#delete").css({ "display": "none" });
    }
});

function ShutdownUI() {
    $("#main").fadeOut(6500);
    $("#html").css({ "display": "none" });
    $("#delete").css({ "display": "none" });
    $(".sidenavcontainer").css({ "display": "none" });
    $('#maincontent').css({ "display": "none" });
    $(".character-box").removeClass('active-char', { duration: 500 });
};

function DisplayUI(data) {
    $('#loadstuffdiv').hide();
    $('.sidenav').fadeIn(500);
    if (data.characters !== null) {
        $.each(data.characters, function(index, char) {
            if (char.charid !== 0) {
                var charid = char.charid;
                $('[data-charid=' + charid + ']').html('<h3 class="chartitle">' + char.firstname + ' ' + char.lastname + '</h3><div class="character-info"><p class="character-info-work"><strong>Height: </strong><span>' + char.height + '</span></p><p class="character-info-money"><strong>Weight: </strong><span>' + char.weight + '</span></p><p class="character-info-dateofbirth"><strong>Date of birth: </strong><span>' + char.dateofbirth + '</span></p> <p class="character-info-gender"><strong>Gender: </strong><span>' + char.sex + '</span></p><p class="character-info-bank"><p class="character-info-desc"><strong>Description:\n </strong><span>' + char.desc + '</span></p><p class="character-info-skill"><strong>Attributes:\n </strong><span>' + char.attr + '</span></p></div>').attr("data-ischar", "true");
            }
        });
    }
};

function RotateMessage() {
    var length = 15
    var result = '';
    var characters = '10';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    $("#message").html(result);
};

function charcont() {
    if ($("#charcont").is(":hidden")) {
        $('#charcont').fadeIn(500);
    } else {
        $('#charcont').fadeOut(500);
    };
    if ($("#infocont").is(":visible")) {
        $('#infocont').fadeOut(500);
    };
    if ($("#identity").is(":visible")) {
        $('#identity').fadeOut(500);
    };
    return
};

function infocont() {
    if ($("#infocont").is(":hidden")) {
        $('#infocont').fadeIn(500);
    } else {
        $('#infocont').fadeOut(500);
    };
    if ($("#charcont").is(":visible")) {
        $('#charcont').fadeOut(500);
    };
    if ($("#identity").is(":visible")) {
        $('#identity').fadeOut(500);
    };
    return
};

function identity() {
    if ($("#identity").is(":hidden")) {
        $('#identity').fadeIn(500);
    } else {
        $('#identity').fadeOut(500);
    };
    if ($("#infocont").is(":visible")) {
        $('#infocont').fadeOut(500);
    };
    if ($("#charcont").is(":visible")) {
        $('#charcont').fadeOut(500);
    };
    return
};