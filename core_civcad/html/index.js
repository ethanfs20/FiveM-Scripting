var resourcename = 'core_civcad'

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === 'ui') {
        if (item.status == true) {
            display(true)
        } else {
            display(false)
        }
    };
    if (item.type === 'update') {
        $('#firstname').attr('placeholder', item.firstname);
        $('#lastname').attr('placeholder', item.lastname);
        $('#sex').attr('placeholder', item.sex);
        $('#height').attr('placeholder', item.height);
        $('#weight').attr('placeholder', item.weight);
        $('#dob').attr('placeholder', item.dateofbirth);
        $('#pfplink').attr('placeholder', item.pfplink);
    }
})

function display(bool) {
    if (bool) {
        $('#main').fadeIn(500);
    } else {
        $('#main').fadeOut(250);
    };
};

function ShowID() {
    if ($('#identitycon').is(':hidden')) {
        $('#identitycon').fadeIn(500);
    } else {
        $('#identitycon').fadeOut(250);
    };
};

function ShowVEH() {
    if ($('#vehiclecon').is(':hidden')) {
        $('#vehiclecon').fadeIn(500);
    } else {
        $('#vehiclecon').fadeOut(250);
    };
};

function ShowWEP() {
    if ($('#weaponcon').is(':hidden')) {
        $('#weaponcon').fadeIn(500);
    } else {
        $('#weaponcon').fadeOut(250);
    };
};

$(document).ready(function() {
    // if a user selects the cancel button it will close and perform a callback closing the UI.
    $('#exit').click(function() {
        if ($('#identitycon').is(':visible')) {
            ShowID()
        };
        if ($('#weaponcon').is(':visible')) {
            ShowWEP()
        };
        display(false)
        $.post('http://' + resourcename + '/exit');
        return
    })
    $('#identity').click(function() {
        if ($('#vehiclecon').is(':visible')) {
            ShowVEH()
        };
        if ($('#weaponcon').is(':visible')) {
            ShowWEP()
        };
        ShowID()
    })
    $('#vehicles').click(function() {
        if ($('#identitycon').is(':visible')) {
            ShowID()
        };
        if ($('#weaponcon').is(':visible')) {
            ShowWEP()
        };
        ShowVEH()
    })
    $('#weapons').click(function() {
        if ($('#identitycon').is(':visible')) {
            ShowID()
        };
        if ($('#vehiclecon').is(':visible')) {
            ShowVEH()
        };
        ShowWEP()
    })
    $('#vehsave').click(function() {
        $.post('http://' + resourcename + '/vehreg')
        return
    })
})

//when the user clicks on the submit button, it will run
$('#submit').click(function() {
    let licensecheck = document.getElementById('license');
    if (licensecheck.checked == true) {
        license = 'VALID'
    };
    let mcheck = document.getElementById('motorcycle');
    if (mcheck.checked == true) {
        m = 'M'
    };
    let cdlcheck = document.getElementById('cdl');
    if (cdlcheck.checked == true) {
        cdl = 'CDL'
    };
    if (sex.length > 0) {
        if (firstname.length >= 11) {
            $.post('http://' + resourcename + '/error', JSON.stringify({
                error: 'Firstname needs to be equal/less than 10 characters!'
            }))
            return
        } else if (!firstname) {
            $.post('http://' + resourcename + '/error', JSON.stringify({
                error: 'Please input a firstname!'
            }))
            return
        };

    };
    // if there are no errors from above, we can send the data back to the original callback and handle it from there
    $.post('http://' + resourcename + '/main', JSON.stringify({
        firstname: firstname,
        lastname: lastname,
        dateofbirth: dob,
        dob: dob,
        sex: sex,
        height: height,
        weight: weight,
        license: license,
        m: m,
        cdl: cdl
    }));
    return;
})