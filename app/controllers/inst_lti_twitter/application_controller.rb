module InstLtiTwitter
  class ApplicationController < ActionController::Base
    before_action :set_default_headers

    def set_default_headers
      response.headers['X-Frame-Options'] = 'ALLOWALL'
    end
  end
end
