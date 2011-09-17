# jquery ->
#   $("body").bind("click", ->
#     $(".dropdown-toggle").parent("li").removeclass("open"))

#   $(".dropdown-toggle").click ->
#     $(this).parent("li").toggleclass('open')
#     return false

jQuery ->
  $(".close").click ->
    $(this).parent("div").remove()
    return false
