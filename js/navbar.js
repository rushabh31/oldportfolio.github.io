/*$( "li" ).hover(
  function() {
    $(this).find("span").stop().animate({
      width:"100%",
      opacity:"1",
    }, 400, function () {
    })
  }, function() {
    $(this).find("span").stop().animate({
      width:"0%",
      opacity:"0",
    }, 400, function () {
    })
  }
);
*/

$('.block-menu').find('a').each(function(){

  var el = $(this),
       elText = el.text();
  
  el.addClass("three-d");
  el.append('<span aria-hidden="true" class="three-d-box"><span class="front">'+elText+'</span><span class="back">'+elText+'</span></span>');


});