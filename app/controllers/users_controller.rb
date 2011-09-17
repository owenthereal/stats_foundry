class UsersController < Clearance::UsersController
  private

  def flash_failure_after_create
    flash.now[:alert] = translate(:bad_email_or_password,
                                  :scope   => [:clearance, :controllers, :passwords],
                                  :default => "There were problems creating your account.")
  end
end
