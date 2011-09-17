jQuery ->
  $(".close").click ->
    $(this).parent("div").remove()
    return false
