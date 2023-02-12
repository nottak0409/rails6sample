class Staff::CustomersController < Staff::Base

    def index
        @customers = Customer.order(:family_name_kana, :given_name_kana)
            .page(params[:page])
    end

    def show
        @customer = Customer.find(params[:id])
    end

    def new
        @customer = Staff::CustomerForm.new
    end

    def edit
        @customer = Staff::CustomerForm.new(Customer.find(params[:id]))
    end
end
