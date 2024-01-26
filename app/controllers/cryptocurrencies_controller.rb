class CryptocurrenciesController < ApplicationController

  def index
    @cryptocurrencies = Cryptocurrency.all

    if params[:search].present?
      @cryptocurrencies = @cryptocurrencies.where('name LIKE ?', "%#{params[:search]}%")
    end

    if params[:filter].present? && params[:filter] != 'All'
      @cryptocurrencies = @cryptocurrencies.joins(:transactions).where('transactions.crypto_type' => params[:filter])
    end


    # Pagination
    @cryptocurrencies = @cryptocurrencies.page(params[:page]).per(10)  # 10 Pages
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
  end

end

