class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.deliver
      redirect_to new_contact_path, notice: t('.sended')
    else
      render :new
    end
  end
end
