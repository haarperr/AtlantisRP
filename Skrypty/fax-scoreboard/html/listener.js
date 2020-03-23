$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#wrap');
         var tb = $('#maintable');
        /*buf.find('table').append("<tr class=\"heading\"><th>ID</th><th>Hex</th></tr>");*/
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        tb.find('table').append(item.text);
        $('#wrap').show();
    }, false);
});