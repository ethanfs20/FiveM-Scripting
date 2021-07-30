window.addEventListener("message", function(event) {
    switch (event.data.action) {
        case "intialization":
            let elemHealth = $('.healthdiv')[0];
            let elemArmor = $('.armordiv')[0];
            let elemFuel = $('.fuel')[0];
            elemHealth.style.left = event.data.healthleft + "%";
            elemHealth.style.bottom = event.data.healthbottom + "%";

            elemArmor.style.left = event.data.armorleft + "%";
            elemArmor.style.bottom = event.data.armorbottom + "%";

            elemFuel.style.left = event.data.fuelleft + "%";
            elemFuel.style.bottom = event.data.fuelbottom + "%";
            break;

        case "edithealth":
            var elem = $('.healthdiv')[0];
            elem.style.left = event.data.left + "%";
            elem.style.bottom = event.data.bottom + "%";
            break;

        case "editarmor":
            var elem = $('.armordiv')[0];
            elem.style.left = event.data.left + "%";
            elem.style.bottom = event.data.bottom + "%";
            break;

        case "editfuel":
            var elem = $('.fueldiv')[0];
            elem.style.left = event.data.left + "%";
            elem.style.bottom = event.data.bottom + "%";
            break;

        case "editseatbelt":
            var elem = $('.seatbeltdiv')[0];
            elem.style.left = event.data.left + "%";
            elem.style.bottom = event.data.bottom + "%";
            break;

        case "update":
            SetProgress(event.data.health, ".health");
            SetProgress(event.data.armor, ".armor");
            SetProgress(event.data.fuel, ".fuel");
            break;

        case "fuelui":
            if (event.data.showfuel == true) {
                $(".fueldiv").fadeIn(500);
            } else {
                $(".fueldiv").fadeOut(500);
            }
            break;

        case "seatbeltui":
            if (event.data.showseatbelt == true) {
                $(".seatbeltdiv").fadeIn(500);
            } else {
                $(".seatbeltdiv").fadeOut(500);
            }
            break;

        case "healthui":
            HealthToggle()
            break;

        case "armorui":
            ArmorToggle()
            break;

        case "reset":
            resettoggles()
            break;

        case "all":
            HealthToggle()
            ArmorToggle()
            break;
    }
});

function resettoggles() {
    if ($(".healthdiv").is(":hidden")) {
        $('.healthdiv').fadeIn(500);
    };
    if ($(".armordiv").is(":hidden")) {
        $('.armordiv').fadeIn(500);
    };
};

function HealthToggle() {
    if ($(".healthdiv").is(":visible")) {
        $('.healthdiv').fadeOut(500);
    } else {
        $('.healthdiv').fadeIn(500);
    };
};

function ArmorToggle() {
    if ($(".armordiv").is(":visible")) {
        $('.armordiv').fadeOut(500);
    } else {
        $('.armordiv').fadeIn(500);
    };
};

function SetProgress(percent, element) {
    let circle = document.querySelector(element);
    let radius = circle.r.baseVal.value;
    let circumference = radius * 2 * Math.PI;
    let html = $(element).parent().parent().find("span");
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;
    let offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
    circle.style.strokeDashoffset = -offset;
    html.text(Math.round(percent));
}