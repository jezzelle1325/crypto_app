class CryptocurrenciesController < ApplicationController

  def index
    @cryptocurrencies = Cryptocurrency.all

    if params[:search].present?
      @cryptocurrencies = @cryptocurrencies.where('name LIKE ?', "%#{params[:search]}%")
    end

    if params[:filter].present? && params[:filter] != 'All'
      @cryptocurrencies = @cryptocurrencies.joins(:transactions).where(transactions: { type: params[:filter] })
    end
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
  end

end
