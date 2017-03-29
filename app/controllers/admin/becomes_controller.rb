class Admin::BecomesController < ::ApplicationController
  before_action :require_can_become_other_users! 

  def show
    user = prevent_becoming_admin_or_developer()
    if user.present?
      sign_in(:user, user, { bypass: true })
      flash[:success] = "You are now logged in as #{user.name}"
    else
      flash[:error] = 'Becoming Admins and Developers is not allowed'
    end
    redirect_to root_url
  end

  def prevent_becoming_admin_or_developer
    User.where.not(id: User.admin.select(:id)).
      where.not(id: User.developer.select(:id)).
      where(id: params[:user_id].to_i).first
  end
end