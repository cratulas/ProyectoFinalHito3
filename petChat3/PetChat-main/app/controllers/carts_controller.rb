class CartsController < ApplicationController
  before_action :authenticate_user!

  def update
    product = params[:cart][:product_id]
    quantity = params[:cart][:quantity]
    current_order.add_product(product, quantity)
    redirect_to root_url, notice: "Product added successfuly"
  end
  
  def show
    @order = current_order
  end

  def pay_with_paypal
    order = Order.find(params[:cart][:order_id])
  
    #price must be in cents
    price = order.total * 100
  
    # Aqui llamamos al express gateway que definimos al inicializar
    # que definimos en nuestro archivo config/development.rb y
    # preparamos la compra, donde se nos devolverá un token para
    # identificar esta venta en particular
  
    response = EXPRESS_GATEWAY.setup_purchase(price,
      ip: request.remote_ip,
      return_url: process_paypal_payment_cart_url,
      cancel_return_url: root_url,
      allow_guest_checkout: true,
      currency: "USD"
    )
  
  
    payment_method = PaymentMethod.find_by(code: "PEC")
    # Aquí creamos nuestro registro en la tabla Payment con el
    # payment method de Paypal, y con estado “processing” pues aún
    # está en proceso
    Payment.create(
      order_id: order.id,
      payment_method_id: payment_method.id,
      status: "processing",
      total: order.total,
      token: response.token
    )
    # redirigimos al usuario a Paypal, para que realice el pago
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end	
  
  
  # esta es la acción que responde al process_paypal_payment_cart_url,
  # que pasamos como valor a return_url en el setup_purchase
  def process_paypal_payment
    details = EXPRESS_GATEWAY.details_for(params[:token])
    express_purchase_options =
      {
        ip: request.remote_ip,
        token: params[:token],
        payer_id: details.payer_id,
        currency: "USD"
      }
  
    price = details.params["order_total"].to_d * 100
  
    response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)
    if response.success?
      payment = Payment.find_by(token: response.token)
      order = payment.order
  
      #update object status
      payment.status = "completed"
      order.status = "completed"
  
      ActiveRecord::Base.transaction do
        order.save!
        payment.save!
      end
      redirect_to root_url, notice: 'El pago se realizo correctamente'
    else
      redirect_to root_url, notice: 'Tuvimos problemas al realizar el pago'
    end
end
end