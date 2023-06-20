# frozen_string_literal: true

module Site
  # Controller to manage locale and inherit all aplication properties
  class BaseController < ApplicationController
    layout 'site'

    before_action :set_locale

    def set_locale
      if I18n.available_locales.include?(params[:locale]&.to_sym)
        I18n.locale = params[:locale]
      else
        redirect_to "/#{I18n.default_locale}"
      end
    end
  end
end
