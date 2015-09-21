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
  $("#commit").on 'click', ->
      $form = $(".edit_church")
    
      $(this).prop('disabled', true);
      
      Stripe.card.createToken($form, stripeResponseHandler);
      return false;

  $('#pricegroup .btn').on 'click', ->
    $amt = parseFloat($(this).find('input[type="radio"]').val())
    $amt += 0.30  
    $amt = $amt.toFixed(2)
    $('#amount').val($amt)
    $('#display_amt').html($amt)
 
  $('.wysihtml5').each ->
        $(this).wysihtml5();
       
      
stripeResponseHandler = (status,response)->
  # An extra line


  $form = $(".edit_church")
  if response.error 
    # Show the errors on the form
    $form.find('.payment-errors').text(response.error.message).removeClass('hide');
    $form.find('#commit').prop('disabled', false);
    return false;
  else 
    # response contains id and card, which contains additional card details
    $token = response.id;
    # Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val($token));
    # and submit
   $form.get(0).submit();
  