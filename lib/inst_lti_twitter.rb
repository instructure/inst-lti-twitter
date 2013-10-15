require 'ostruct'
require 'ims'
require 'inst_lti_twitter/inst_lti_twitter_config'

module InstLtiTwitter
  mattr_accessor :app_root

  def self.setup
    yield self
  end

  def self.config
    yield(InstLtiTwitter::Config)
  end
end

require 'inst_lti_twitter/engine'