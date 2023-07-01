module TaskPoolsHelper
  def owns(task, current_user)
    task.users.include?(current_user) || current_user.teamleader?
  end

  def to_do(task)
    task.progress == "to_do"
  end

  def in_progress(task)
    task.progress == "in_progress"
  end

  def done(task)
    task.progress == "done"
  end

  def show_attachment(task)
    if task.attachment.id
      blob = ActiveStorage::Blob.find(task.attachment.id) 
      return blob.filename.to_s
    else
      return "No attached file yet."
    end
  end
end
