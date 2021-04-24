module RequestHelpers
  # current_userメソッドのスタブ
  def set_current_user(user)
    allow_any_instance_of(Api::BaseController).to receive(:current_user).and_return(user)
  end
end
