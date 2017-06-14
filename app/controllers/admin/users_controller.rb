module Admin
  class UsersController < AdminController
    skip_before_action :require_admin!, only: [:stop_impersonating]
    respond_to :html, :json

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "User created successfully"
        redirect_to admin_users_path
      else
        flash[:error] = "Invalid fields"
        render :new
      end
    end

    def index
      @users = User.all

      respond_with(@users)
    end

    def impersonate
      user = User.find(params[:id])
      track_impersonation(user, 'Start')
      impersonate_user(user)
      redirect_to root_path
    end

    def stop_impersonating
      track_impersonation(current_user, 'Stop')
      stop_impersonating_user
      redirect_to admin_users_path
    end

    private

    def track_impersonation(user, status)
      analytics_track(
        true_user,
        "Impersonation #{status}",
        impersonated_user_id: user.id,
        impersonated_user_email: user.email,
        impersonated_by_email: true_user.email,
      )
    end

    def user_params
      params.require(:user).permit(:first_name,
                            :last_name,
                            :email,
                            :password,
                            :password_confirmation,
                            roles: [])
    end
  end
end
