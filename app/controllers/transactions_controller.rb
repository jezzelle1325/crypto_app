class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to transactions_path, alert: "Transaction not found."
  end
end
