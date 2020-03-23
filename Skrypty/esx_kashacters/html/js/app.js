$(".character-box").hover(
    function() {
        $(this).css({
            "background": "rgba(0, 0, 0, 0.47)",
            "transition": "200ms",
        });
    }, function() {
        $(this).css({
            "background": "rgba(0, 0, 0, 0.77)",
            "transition": "200ms",
        });
    }
);

$(".character-box").click(function () {
    $(".character-box").removeClass('active-char');
    $(this).addClass('active-char');
    $(".character-buttons").css({"display":"block"});
    if ($(this).attr("data-ischar") === "true") {
        $("#delete").css({"display":"block"});
    } else {
        $("#delete").css({"display":"none"});
    }
});

$("#play-char").click(function () {
    $.post("http://esx_kashacters/CharacterChosen", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
        ischar: $('.active-char').attr("data-ischar"),
    }));
    Kashacter.CloseUI();
});

$("#deletechar").click(function () {
    $.post("http://esx_kashacters/DeleteCharacter", JSON.stringify({
        charid: $('.active-char').attr("data-charid"),
    }));
    Kashacter.CloseUI();
});

(() => {
    Kashacter = {};

    Kashacter.ShowUI = function(data) {
        $('.main-container').css({"display":"block"});
        if(data.characters !== null) {
            $.each(data.characters, function (index, char) {
                if (char.charid !== 0) {
                    var charid = char.identifier.charAt(4);
                    var statusGood = 0
                    var statusBad = 0
                    var displayStatus = 0
                    if (char.statusSpoleczny > 0 ) {
                        statusBad = 0
                        statusGood = ( ( char.statusSpoleczny * 100 ) / 100000 )
                        displayStatus = statusGood
                    }
                    if (char.statusSpoleczny < 0 ){
                        statusGood = 0
                        statusBad = ( ( char.statusSpoleczny * 100 ) / 100000 )
                        statusBad = ( ( statusBad ) * ( -1 ) )
                        displayStatus = statusBad
                    }
                    $('[data-charid=' + charid + ']').html('<h3 class="character-fullname">'+ char.firstname +' '+ char.lastname +'</h3><div class="character-info"><p class="character-info-work"><center><span>'+ char.job +'</span></center></p><p class="character-info-money"><strong>W portfelu: </strong><span>'+ char.money +'</span></p><p class="character-info-bank"><strong>Bank: </strong><span>'+ char.bank +'</span></p> <p class="character-info-dateofbirth"><strong>Status społeczny:</strong><span></span> <center><div style="display: inline-block;background: black;box-shadow: 0px 0px 2px #000;width: 50%;height: 10px;"><div style="width: 100%;height: 10px;background: linear-gradient(to left, #d63535 '+ statusBad +'%, #000 '+ statusBad +'%);"></div></div><div style="display: inline-block;box-shadow: 0px 0px 2px #000;background: black;width: 50%;height: 10px;"><div style="/* background: red; */width: 100%;height: 10px;background: linear-gradient(to right, #00ff2b '+statusGood +'%, #000 '+statusGood +'%);"></div></div></center></p> <p class="character-info-gender"><strong>Płeć: </strong><span>'+ char.sex +'</span></p></div>').attr("data-ischar", "true");
                }
            });
        }
    };

    Kashacter.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $("#delete").css({"display":"none"});
		$(".character-box").html('<h3 class="character-fullname"></h3><div class="character-info"><p class="character-info-new" style="padding-top: 62%; text-align: center;"><i class="fas fa-plus"></i> Stwórz nową postać</p></div>').attr("data-ischar", "false");
    };
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    Kashacter.ShowUI(event.data);
                    break;
            }
        })
    }

})();