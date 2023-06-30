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
end
