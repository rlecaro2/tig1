$(function(){
  var start = $('#start');
  var stop = $('#stop');

  var milliseconds = 1024 * 3;
  var id = null;

  var update = function(){
    id = setInterval(function(){

      $.ajax('whenever_logs.json?silence=logger', {
        type: 'GET',
        success: function(data) {
          var lines = data
          $('#logs').html(lines.join('\n'));   

        },
        error: function() { }
      });
      
    }, milliseconds);
  };

  start.click(function(){ start.toggle(); stop.toggle(); update(); });
  stop.click(function(){ stop.toggle(); start.toggle(); clearInterval(id); });

  update();
}); 