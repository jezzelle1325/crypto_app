class CryptocurrenciesController < ApplicationController
  def index
    @cryptocurrencies = Cryptocurrency.all
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
  end
end
