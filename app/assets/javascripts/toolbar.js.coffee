jQuery ->
  $("body").bind("click", ->
    $(".dropdown-toggle").parent("li").removeClass("open"))

  $(".dropdown-toggle").click ->
    $(this).parent("li").toggleClass('open')
    return false
