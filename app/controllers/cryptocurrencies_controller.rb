class CryptocurrenciesController < ApplicationController

  before_action :set_current_user

  def index
    @filter = params[:filter]
    @cryptocurrencies = Cryptocurrency.all.includes(:transactions)

    if current_user
      watched_crypto_ids = current_user.watched_cryptocurrencies.pluck(:cryptocurrency_id)
      @watched_cryptocurrency_ids = Set.new(watched_crypto_ids)
    else
      @watched_cryptocurrency_ids = Set.new
    end

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


  def show
    @cryptocurrency = Cryptocurrency.includes(:transactions, :watched_cryptocurrencies).find(params[:id])
    @filter = params[:filter]

    # Filter transactions based on the filter
    @transactions = if @filter.present? && @filter != 'All'
                      @cryptocurrency.transactions.where('lower(crypto_type) = ?', @filter.downcase)
                    else
                      @cryptocurrency.transactions
                    end

    # Fetch all watched cryptocurrencies for this cryptocurrency
    @watched_cryptocurrencies = @cryptocurrency.watched_cryptocurrencies
  end

  def set_current_user
    @current_user = User.first # This assumes there is at least one user in your database
  end

  def watch
    crypto_id = params[:crypto_id]
    user_id = current_user.id

    # Create or update the watched cryptocurrency record
    watched_crypto = WatchedCryptocurrency.find_or_initialize_by(user_id: user_id, cryptocurrency_id: crypto_id)
    watched_crypto.interest_level = "Interested"
    watched_crypto.save

    redirect_back(fallback_location: root_path)
  end

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