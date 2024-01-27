class CryptocurrenciesController < ApplicationController
  def index
    @filter = params[:filter]
    @cryptocurrencies = Cryptocurrency.all.includes(:transactions)

    if params[:search].present?
      @cryptocurrencies = @cryptocurrencies.where('name LIKE ?', "%#{params[:search]}%")
    end

    if @filter.present?
      if @filter != 'All'
        # Filter for either "Buy" or "Sell"
        @cryptocurrencies = @cryptocurrencies.joins(:transactions)
                                             .where(transactions: { crypto_type: @filter.downcase })
                                             .distinct
      else
        # For "All"
        @cryptocurrencies = @cryptocurrencies.joins(:transactions)
                                             .where(transactions: { crypto_type: ['buy', 'sell'] })
                                             .distinct
      end
    end

    # Pagination
    @cryptocurrencies = @cryptocurrencies.page(params[:page]).per(10)
  end


  # TEST CODE
  # def show
  #   @cryptocurrency = Cryptocurrency.find(params[:id])
  #   @filter = params[:filter]

  #   # Load transactions based on the filter
  #   @transactions = if @filter.present? && @filter != 'All'
  #                     @cryptocurrency.transactions.where('lower(crypto_type) = ?', @filter.downcase)
  #                   else
  #                     @cryptocurrency.transactions
  #                   end
  # end

  def show
    @cryptocurrency = Cryptocurrency.includes(:transactions).find(params[:id])
    @filter = params[:filter]
  end
end
