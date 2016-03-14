$ ->
  $('a[data-toggle=modal]').on 'click', ->
    $('.dropdown').removeClass('open')
  $('a[data-target=#ajax-modal]').on 'click', (e)->
     e.preventDefault()
     e.stopPropagation();
     $.rails.handleRemote( $(this) );
  $(document).on 'click', '[data-dismiss=modal], .modal-scrollable', ->
    $('.modal-body-content').empty()
  $(document).on 'click', '#ajax-modal', (e) ->
    e.stopPropagation();
    #price change on wizard


  #if the price wizard is hidden in small devices use select box
  $('select.cs-amount').on 'change', ->
    if($(this).val() != 'custom')
      $(".small-custom-price").addClass('hidden')
      $(this).removeClass('hidden')
      $amt = parseFloat($(this).val())
      $amt += 0.00
      $amt = $amt.toFixed(2)
      $('#amount').val($amt)
      $('#display_amt').html($amt)
    else
      $(".small-custom-price").removeClass('hidden')
      $('.cs-wrapper').addClass('hidden')

  $('#close-custom').on 'click', ->
   $(".small-custom-price").addClass('hidden')
   $('.cs-wrapper').removeClass('hidden')



  #for bigger screen price wizard is availbale
  $('#pricegroup .btn').on 'click', ->
    #if not custom price
    if(!$(this).hasClass('custom-price'))
      $('.custom-input').addClass('hidden')
      $('.custom-lbl').removeClass('hidden')

      $amt = parseFloat($(this).find('input[type="radio"]').val())
      $amt += 0.00
      $amt = $amt.toFixed(2)
      $('#amount').val($amt)
      $('#display_amt').html($amt)
    else
      $("#pricegroup .btn.active").removeClass("active")
      $(this).addClass('active')
      $(this).find('.custom-input').removeClass('hidden').focus()
      $(this).find('.custom-input input').focus()
      $(this).find('.custom-lbl').addClass('hidden')
   #

  $(".custom-input input").bind 'blur', ->
    $amt = parseFloat($(this).val())
    $amt += 0.00
    $amt = $amt.toFixed(2)
    $('#amount').val($amt)
    $('#display_amt').html($amt)
#    alert($amt)

  $('.wysihtml5').each ->
        $(this).wysihtml5();
