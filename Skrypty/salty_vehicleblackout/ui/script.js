$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "logo") {

				if (item.display === true) {
					$('#logo').fadeIn( "slow" );
				} else if (item.display === false) {
					$('#logo').fadeOut( "slow" );
				}
			}
			var item2 = event.data;
			if (item2 !== undefined && item2.type === "logo2") {

				if (item2.display === true) {
					$('#logo2').fadeIn( "slow" );
				} else if (item2.display === false) {
					$('#logo2').fadeOut( "slow" );
				}
			}
		});
	};
});