class AttachmentsController < ApplicationController
  layout 'dashboard'
  before_action :require_signed_in!

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
      respond_to do |format|
        format.html { redirect_to attachments_url, notice: 'Created Done' }
        format.json
      end
    end
  end

  def index
    @attachments = Attachment.all
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Delete Done' }
    end
  end

  private
  def attachment_params
    params.require(:attachment).permit(:file, :remote_file_url)
  end
end
