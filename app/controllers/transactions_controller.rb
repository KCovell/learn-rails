class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(secure_params)
    if @transaction.valid?
      # TODO save data
      # TODO send message
      flash[:notice] = "New Transaction submitted by #{@transaction.name}."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:transaction).permit(:name, :date, :vendor, :amount)
  end

end