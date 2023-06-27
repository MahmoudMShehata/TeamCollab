def login(user)
  post user_session_path, params: {
    user: {
      email: user.email, password: user.password
    }
  }
  follow_redirect!
end


def login_admin(admin)
  post admin_user_session_path, params: {
    admin_user: {
      email: admin.email, password: admin.password
    }
  }
end
