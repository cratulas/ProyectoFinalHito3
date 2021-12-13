class HomeController < ApplicationController
  before_action :authenticate_user!, only: :dashboard
  def indexVisit
  end

  def indexUser
    @users = User.all
  end

  def market
    @products = Product.all
  end

  def dashboard
    @sales_amount_month = Sale.group_by_month(:sale_date, last: 12).sum(:amount)
    @sales_average = Sale.group_by_month(:sale_date, last: 12).average(:amount)
    
    @sales_amount12 = Sale.where('sale_date > ?', 1.year.ago
    ).group(:origin).count

    @sales_amount6 = Sale.where('sale_date > ?', 6.month.ago
    ).group(:origin).count

    @sales_amount3 = Sale.where('sale_date > ?', 3.month.ago
    ).group(:origin).count

    @sales_amount1 = Sale.where('sale_date > ?', 1.month.ago
    ).group(:origin).count
  end
end
