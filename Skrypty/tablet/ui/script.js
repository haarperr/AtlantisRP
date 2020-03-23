$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			
			if (item !== undefined && item.officer != "") {


				if (item.display === true) {
					
					$('#tablet').delay(100).fadeIn( "slow" );
					$('#name').text(item.officer);
					$('#date').text("asd");
				} else if (item.display === false) {
					$('#tablet').fadeOut( "slow" );
				}
			}
			if (item.section == "plates" && item.display === true){
					toggleMenu("plates");
					$('#plates').html(item.plate);

			} 
			else if (item.section == "browse" && item.display === true){
					/*toggleMenu("browse");*/
					$('#browse').html(item.browse);
					$('#table_id').DataTable( {
						"scrollY":        "200px",
						"scrollCollapse": true
					} );

			}
			else if (item.section == "jail" && item.display === true){
					toggleMenu("jail");
					

			}
			else if (item.wasenabled === true && item.pressz === false){
					$('#tablet').delay(100).fadeIn( "slow" );
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

function toggleMenu(current) {
	$('#plates').fadeOut( "fast" );
    $('#user').fadeOut( "fast" );
    $('#jail').fadeOut( "fast" );
    $('#fines').fadeOut( "fast" );
    $('#notes').fadeOut( "fast" );
    $('#browse').fadeOut( "fast" );
    $('#front').fadeOut( "fast" );

    $('#'+current).fadeIn( "fast" );
}