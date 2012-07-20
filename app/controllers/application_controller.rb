class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  
  def signed_in?
    @now = DateTime.current().to_time.iso8601
    @jwt = JWT.encode(
        {
            'consumerKey' => "annotationstudio.org",
            'userId' => current_user.email,
            'issuedAt' => @now,
            'ttl' => 86400
        }, 
        "secretgoeshere"
    )
  end
  helper_method :signed_in?

  def authenticate
    redirect_to root_path, notice: "You need to be signed in" unless signed_in?
  end

end


