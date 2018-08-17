class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    if current_user.has_posts?
      redirect_to homepage_path, notice: t('.destroy_account_with_posts')
    else
      super
    end
  end
end
