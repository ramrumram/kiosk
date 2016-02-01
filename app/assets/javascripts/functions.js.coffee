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

  window.submitToStripe = () ->
    $("#ajx-loader").removeClass("hide")
    $form = $(".edit_church")
    $cvc = $("#cvc").val()
    $exp_mn = $("#exp_mn").val()
    $exp_yr = $("#exp_yr").val()
    $number = $("#number").val()
    $cust_name = $(".cust_name").val()
    $(this).prop('disabled', true);

    Stripe.card.createToken({
      number: $number,
      cvc: $cvc,
      exp_month: $exp_mn,
      exp_year: $exp_yr,
      name: $cust_name
    }, stripeResponseHandler);
    return false;


  #if the price wizard is hidden in small devices use select box
  $('select.cs-amount').on 'change', ->
    $amt = parseFloat($(this).val())
    $amt += 0.30
    $amt = $amt.toFixed(2)
    $('#amount').val($amt)
    $('#display_amt').html($amt)

  #for bigger screen price wizard is availbale
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

  $("#ajx-loader").addClass("hide")
  $form = $(".edit_church")
  if response.error
    # Show the errors on the form
    $form.find('.payment-errors').text(response.error.message).removeClass('hide');
    $('#rootwizard').find('.pager .previous').show();
    return false;
  else
    # response contains id and card, which contains additional card details
    $token = response.id;
    # Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val($token));
    # and submit
   $form.get(0).submit();
