# frozen_string_literal: true

class ApplicationController < ActionController::API
  # include JsonapiErrorsHandler

  before_action :set_default_format

  # JsonapiErrorsHandler offers 4 predefined errors:
  # JsonapiErrorsHandler::Errors::Invalid
  # JsonapiErrorsHandler::Errors::Forbidden
  # JsonapiErrorsHandler::Errors::NotFound
  # JsonapiErrorsHandler::Errors::Unauthorized
  # ErrorMapper.map_errors!({
  #                           'ActiveRecord::RecordNotFound' => 'JsonapiErrorsHandler::Errors::NotFound'
  #                         })

  # rescue_from ::StandardError must be defined first
  rescue_from ::StandardError, with: ->(e) { handle_error(e) }
  rescue_from ActiveModel::ValidationError, with: ->(e) { handle_validation_error(e) }
  rescue_from ActiveRecord::RecordInvalid, with: ->(e) { handle_validation_error(e) }

  private

  def handle_validation_error(error)
    raies error
    # error_model = error.try(:model) || error.try(:record)
    # messages = error_model.errors.messages
    # mapped = JsonapiErrorsHandler::Errors::Invalid.new(errors: messages)
    # render_error(mapped)
  end

  def set_default_format
    request.format = :json
  end
end
