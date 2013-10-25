class AttachmentsController < ApplicationController
  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      redirect_to attachments_url
    end
  end

  def index
    @attachments = Attachment.all
  end

  def destroy
  end

  private
  def attachment_params
    params.require(:attachment).permit(:file, :remote_file_url)
  end
end
