class UsersController < ApplicationController
  before_action :only_allow_one_user
  layout 'auth'

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created. Please sign in here.';
        format.html { redirect_to sign_in_url }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def only_allow_one_user
      redirect_to root_url, alert: 'Sorry, this site is not open for sign up' if has_one_user?
    end

    def has_one_user?
      User.count >= 1
    end
end
