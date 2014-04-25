class SessionsController < ApplicationController
  def create
    user = UserForm.new(info)

    if !user.new_record?
      flash[:notice] = "Logado com sucesso."
    else
      if user.submit
        flash[:notice] = "Sucesso! Sua conta foi criada com sucesso."
      else
        flash[:error] = "Não foi possível entrar."
      end
    end

    session[:user_id] = user.id if user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Você foi deslogado.'
  end

  private

  def info
    info = request.env['omniauth.auth'].info. \
      slice(:nickname, :name, :image, :email)
    user_params = { username: info[:nickname], avatar_url: info[:image], \
      email: info[:email], name: info[:name] || info[:nickname], \
      github_uid: request.env['omniauth.auth'].uid }
  end
end
