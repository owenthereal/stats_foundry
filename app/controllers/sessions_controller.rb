class SessionsController < Clearance::SessionsController
 private

  def flash_failure_after_create
    flash.now[:alert] = translate(:bad_email_or_password,
                                  :scope   => [:clearance, :controllers, :sessions],
                                  :default => "Incorrect login or password.")
  end
end
