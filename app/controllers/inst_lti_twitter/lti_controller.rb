require_dependency "inst_lti_twitter/application_controller"

module InstLtiTwitter
  class LtiController < ApplicationController

    def index
      @launch_params = params.reject!{ |k,v| ['controller','action'].include? k }
    end
    
  end
end
