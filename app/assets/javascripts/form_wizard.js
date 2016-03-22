/* ============================================================
 * Form Wizard
 * Multistep form wizard using Bootstrap Wizard Plugin
 * For DEMO purposes only. Extract what you need.
 * ============================================================ */
(function($) {
    $(document).ready(function() {

        function submitToCC() {

          $(".payment-errors").addClass("hide")
          $("#ajx-loader").removeClass("hide")
          $form = $(".edit_kiosk")
          $cvc = $("#cvc").val()
          $exp_mn = $("#exp_mn").val()
          $exp_yr = $("#exp_yr").val()
          $number = $("#number").val()
          $cust_name = $(".cust_name").val()
        //  $(this).prop('disabled', true);
          $form.submit()

        }


        $('#rootwizard').bootstrapWizard({
        	onTabClick: function(tab, navigation, index) {


				return false;
				},
            onTabShow: function(tab, navigation, index) {


              $valid = true

              //form validtion
              if (index == 1  ) {


               $amt = parseFloat($(".custom-input input").val())


               if($amt == 0 || isNaN($amt) || $amt < 0) {
                   $('#rootwizard').bootstrapWizard('show',0);

               }



             }
              if (index == 2  ) {

                $cust_name = $(".cust_name").val()
                $cvc = $("#cvc").val()
                $number = $("#number").val()


                if ($cvc == "" || $number == "" || $cust_name == "" ) {

                    $(".payment-errors").html("Mandatory fields cannot be empty").removeClass("hide")
                      $('#rootwizard').bootstrapWizard('show',1);
                    $valid = false
                }

                  //only if the form passed validatoins
                if ($valid) {
                  $(".payment-errors").addClass('hide')

                  submitToCC();
                }
              }


                var $total = navigation.find('li').length;
                var $current = index + 1;

                // If it's the last tab then hide the last button and show the finish instead..
                if ($current >= $total && $valid) {

                  $('#rootwizard').find('.pager .previous').hide();
                  $('#rootwizard').find('.pager .next').hide();


                } //don't show the thrid tab if on test preview

                else if (index == 1  && $("#merchid_warning").html() ) {
                    $('#rootwizard').find('.pager .next').hide();
                }
                else {

                    $('#rootwizard').find('.pager .next').show();
                //    $('#rootwizard').find('.pager .finish').hide();
                }

                var li = navigation.find('li.active');

                var btnNext = $('#rootwizard').find('.pager .next').find('button');
                var btnPrev = $('#rootwizard').find('.pager .previous').find('button');

                // remove fontAwesome icon classes
                function removeIcons(btn) {
                    btn.removeClass(function(index, css) {
                        return (css.match(/(^|\s)fa-\S+/g) || []).join(' ');
                    });
                }

                if ($current > 1 && $current < $total) {

                    var nextIcon = li.next().find('.fa');
                    var nextIconClass = nextIcon.attr('class').match(/fa-[\w-]*/).join();

                    removeIcons(btnNext);
                    btnNext.addClass(nextIconClass + ' btn-animated from-left fa');

                    var prevIcon = li.prev().find('.fa');
                    var prevIconClass = prevIcon.attr('class').match(/fa-[\w-]*/).join();

                    removeIcons(btnPrev);
                    btnPrev.addClass(prevIconClass + ' btn-animated from-left fa');
                } else if ($current == 1) {
                    // remove classes needed for button animations from previous button
                    btnPrev.removeClass('btn-animated from-left fa');
                    removeIcons(btnPrev);
                } else {
                    // remove classes needed for button animations from next button
                    btnNext.removeClass('btn-animated from-left fa');
                    removeIcons(btnNext);
                }
            },
            onNext: function(tab, navigation, index) {
                console.log("Showing next tab");

            },
            onPrevious: function(tab, navigation, index) {
                $('.payment-errors').addClass('hide')
            },
            onInit: function() {
                $('#rootwizard ul').removeClass('nav-pills');
            }

        });

        $('.remove-item').click(function() {
            $(this).parents('tr').fadeOut(function() {
                $(this).remove();
            });
        });

    });

})(window.jQuery);
