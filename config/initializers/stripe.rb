Rails.configuration.stripe = {
  :publishable_key => "pk_test_Q9OdXuNd4HxL1ScBchlyQ83R",
  :secret_key      => "sk_test_Ap8MIOeZEKKog4TN9TQq390T"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]