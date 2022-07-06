module PicturesHelper
  def confirm_throught
    if action_name == 'new' || action_name == 'create'
      confirm_pictures_path
    else
      picture_path
    end
  end
end
