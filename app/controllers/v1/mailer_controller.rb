class V1::MailerController < ApplicationController
  before_action :check_params

  def contact
    email = ContactMailer.contact_email(email_params)

    begin
      email.deliver_now
      render json: { message: 'Email was sent!', email: params['email'] }, status: :ok
    rescue => exception
      render json: { message: 'Could not send email' }, status: :unprocessable_entity
    end
  end

  private
  def check_params
    if !params.has_key?(:email)
      render json: { message: 'Please provide an email to send with' }, status: :uprocessable_entitiy
    end
    if !params.has_key? :message
      render json: { message: 'Please provide an message to send' }, status: :uprocessable_entitiy
    end
  end
  def email_params
    params.permit(
      :name,
      :email,
      :phone,
      :services,
      :message
    )
  end
end
