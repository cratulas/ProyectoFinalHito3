class HomeController < ApplicationController
  def indexVisit
  end

  def indexUser
    @users = User.all
  end

  def market
    @products = Product.all
  end
end
