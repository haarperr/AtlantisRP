$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			
			if (item !== undefined && item.officer != "") {


				if (item.display === true) {
					
					$('#logo').delay(100).fadeIn( "slow" );
					$('#name').text(item.officer);
					$('#date').text("asd");
				} else if (item.display === false) {
					$('#logo').fadeOut( "slow" );
				}
			}
			if (item.wasenabled === true && item.pressz === true){
					$('#logo').fadeOut( "fast" );
				} else if (item.wasenabled === true && item.pressz === false){
					$('#logo').delay(100).fadeIn( "slow" );
					$('#name').text(item.officer);
					$('#date').text("asd");
				}
		});
	};
});

$(document).ready(function() {
    	var interval = setInterval(function() {
        var dt = new Date();
        var month = dt.getMonth() + 1
		var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds() + " " + dt.getDate() + "/" + month  + "/" + dt.getFullYear();

        
        $('#date').text(time);
    }, 100);
    
    
});

function czas() {
	var interval = setInterval(function() {
        var dt = new Date();
		var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds() + dt.getDay() + "/" + dt.getMonth() + "/";

        
        $('#date').text(time);
    }, 100);
}