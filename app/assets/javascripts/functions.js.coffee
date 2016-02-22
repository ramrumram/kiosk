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
    $amt = parseFloat($(this).val())
    $amt += 0.00
    $amt = $amt.toFixed(2)
    $('#amount').val($amt)
    $('#display_amt').html($amt)

  #for bigger screen price wizard is availbale
  $('#pricegroup .btn').on 'click', ->
    $amt = parseFloat($(this).find('input[type="radio"]').val())
    $amt += 0.00
    $amt = $amt.toFixed(2)
    $('#amount').val($amt)
    $('#display_amt').html($amt)



  $('.wysihtml5').each ->
        $(this).wysihtml5();
