class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(secure_params)
    if @transaction.valid?
      @transaction.update_spreadsheet
      # TODO send message
      flash[:notice] = "New Transaction submitted for #{@transaction.name}."
      render :new
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:transaction).permit(:name, :date, :vendor, :amount)
  end

end