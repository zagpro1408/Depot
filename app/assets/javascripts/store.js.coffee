# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Добавление в корзину по нажатию по изображению
# Связывание переходов из внесайта и с нашего сайта
# Ожидание клика по изображению
# Поиск кнопки submit для того, чтобы CS нажал по ней

$(document).on "ready page:change", ->
  $('.store .entry > img').click ->
    $(this).parent().find(':submit').click()
