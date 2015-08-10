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