# frozen_string_literal: true

module TaskPoolsHelper
  def owns(task, current_user)
    task.users.include?(current_user) || current_user.teamleader?
  end

  def to_do(task)
    task.progress == 'to_do'
  end

  def in_progress(task)
    task.progress == 'in_progress'
  end

  def done(task)
    task.progress == 'done'
  end

  def upload_to_s3(task)
    s3 = Aws::S3::Resource.new(region: 'eu-north-1', access_key_id: 'AKIA2IPOOV7LXLZ72MFZ', secret_access_key: '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')
    blob = ActiveStorage::Blob.find(task.attachment.id)

    obj = s3.bucket('teamcollabs-development').object(blob.key)
    
    obj.presigned_url(:get, response_content_disposition: "attachment; filename=#{blob.filename.to_s}")
  end

  def show_attachment(task)
    return 'No attached file yet.' unless task.attachment.id

    blob = ActiveStorage::Blob.find(task.attachment.id)
    blob.filename.to_s
  end
end
