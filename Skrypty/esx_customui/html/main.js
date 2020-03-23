
var rgbStart = [139,195,74]
var rgbEnd = [183,28,28]

$(function(){
	window.addEventListener('message', function(event) {
		if (event.data.action == "setValue"){
			if (event.data.key == "job"){
				setJobIcon(event.data.icon)
			}
			setValue(event.data.key, event.data.value)

		}else if (event.data.action == "updateStatus"){
			updateStatus(event.data.status);
		}else if (event.data.action == "updateHealth"){
			updateHealth(event.data.value);
		}else if (event.data.action == "setTalking"){

			setTalking(event.data.value)
		}else if (event.data.action == "setProximity"){
			setProximity(event.data.value)
		}else if (event.data.action == "toggle"){
			if (event.data.show){
				$('#ui').show();
			} else{
				$('#ui').hide();
			}
		}else if (event.data.action == "togHealth"){
			if (event.data.show){
				$('#health').show();
			} else{
				$('#health').hide();
			}
		} else if (event.data.action == "togBeltsOn"){
			if (event.data.show){
				updateBelts(1)
				setBelts("show")
			} else{
				updateBelts(0)
				setBelts("hide");
			}
		} else if (event.data.action == "togBelts"){
			if (event.data.show){
				$('#belts').show();
			} else{
				$('#belts').hide();
			}
		} else if (event.data.action == "toggleCar"){
			if (event.data.show){
				//$('.carStats').show();
			} else{
				//$('.carStats').hide();
			}
		}else if (event.data.action == "updateCarStatus"){
			updateCarStatus(event.data.status)
		/*}else if (event.data.action == "updateWeight"){
			updateWeight(event.data.weight)*/
		}
	});

});

function updateWeight(weight){


	var bgcolor = colourGradient(weight/100, rgbEnd, rgbStart)
	$('#weight .bg').css('height', weight+'%')
	$('#weight .bg').css('background-color', 'rgb(' + bgcolor[0] +','+ bgcolor[1] +','+ bgcolor[2] +')')
}

function updateCarStatus(status){
	var gas = status[0]
	$('#gas .bg').css('height', gas.percent+'%')
	var bgcolor = colourGradient(gas.percent/100, rgbStart, rgbEnd)
	//var bgcolor = colourGradient(0.1, rgbStart, rgbEnd)
	//$('#gas .bg').css('height', '10%')
	$('#gas .bg').css('background-color', 'rgb(' + bgcolor[0] +','+ bgcolor[1] +','+ bgcolor[2] +')')
}

function setValue(key, value){
	$('#'+key+' span').html(value)

}

function setJobIcon(value){
	$('#job img').attr('src', 'img/jobs/'+value+'.png')
}

function updateStatus(status){
	var hunger = status[0]
	var thirst = status[1]
	/*var drunk = status[2] */
	$('#hunger .bg').css('height', hunger.percent+'%')
	$('#water .bg').css('height', thirst.percent+'%')
	/*$('#drunk .bg').css('height', drunk.percent+'%')*/


	if (drunk.percent > 0){
		$('#drunk').show();
	}else{
		$('#drunk').hide();
	}

}

function updateHealth(value){
	var health = value
	$('#health .bg').css('height', health + '%')
}
function updateBelts(value){
	var belts = value
	$('#beltsOff .bg').css('height', belts + '%')
}
function setProximity(value){
	var color;
	var speaker;
	var percent;
	if (value == "1"){
		color = "rgba(18, 105, 202, 0.7)";
		speaker = 1;
		percent = 30;
	}else if (value == "2"){
		color = "rgba(18, 105, 202, 0.7)"
		speaker = 2;
		percent = 50;
	}else if (value == "3"){
		color = "rgba(18, 105, 202, 0.7)"
		speaker = 3;
		percent = 100;
	}
	else if (value == "4"){
		color = "rgba(18, 105, 202, 0.7)"
		speaker = 4;
		percent = 0;
	}
	$('#voice .bg').css('height', percent+'%')
	$('#voice .bg').css('background-color', color);
	$('#voice img').attr('src', 'img/speaker'+speaker+'.png');
}	
function setBelts(value){
	var color;
	var belts;
	var percent;
	if (value == "show"){
		color = "rgba(18, 105, 202, 0.7)";
		belts = "beltsOn";
		percent = 100;
	}else{
		color = "rgba(18, 105, 202, 0.7)"
		belts = "beltsOff";
		percent = 0;
	}
	$('#belts .bg').css('height', percent+'%')
	$('#belts .bg').css('background-color', color);
	$('#belts img').attr('src', 'img/'+belts+'.png');
}
function setTalking(value){
	if (value){
		//#64B5F6
		$('#voice').css('border', '3px solid #03A9F4')
	}else{
		//#81C784
		$('#voice').css('border', 'none')
	}
}

//API Shit
function colourGradient(p, rgb_beginning, rgb_end){
    var w = p * 2 - 1;

    var w1 = (w + 1) / 2.0;
    var w2 = 1 - w1;

    var rgb = [parseInt(rgb_beginning[0] * w1 + rgb_end[0] * w2),
        	parseInt(rgb_beginning[1] * w1 + rgb_end[1] * w2),
            parseInt(rgb_beginning[2] * w1 + rgb_end[2] * w2)];
    return rgb;
};