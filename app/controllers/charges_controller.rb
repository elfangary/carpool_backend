class ChargesController < ApplicationController


    def create

      Stripe.api_key = 'sk_test_RTXwBOC4eC3r23FjmBbqeBQ7'

      amount = params[:amount]

      charge = Stripe::Charge.create(
      :amount      => amount,
      :source      => params[:stripeToken],
      :description => 'Payment',
      :currency    => 'egp'
      )

      render json: charge.amount/100 , status: :ok
    end

end
