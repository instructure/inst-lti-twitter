# Twitter LTI Tool

[![Gem Version](https://badge.fury.io/rb/inst_lti_twitter.png)](http://badge.fury.io/rb/inst_lti_twitter)

Embed a Twitter widget into your LMS with this LTI App.

### Usage

This gem is a mountable Rails engine. To use this you will need to include the gem into a Rails application then mount the engine in the routes file. Example:

    # Gemfile
    gem "inst_lti_twitter", "~> 0.0.1"

    # routes.rb
    mount InstLtiTwitter::Engine, at: "/twitter"

You will also need to create a new file in your config folder called `inst_lti_twitter_config.yml`. This will contain the credentials for using the Twitter API.

    default: &default
      inst_lti_twitter_consumer_key:        INST_LTI_TWITTER_CONSUMER_KEY
      inst_lti_twitter_consumer_secret:     INST_LTI_TWITTER_CONSUMER_SECRET
      inst_lti_twitter_access_token:        INST_LTI_TWITTER_ACCESS_TOKEN
      inst_lti_twitter_access_token_secret: INST_LTI_TWITTER_ACCESS_TOKEN_SECRET

    development:
      <<: *default

    test:
      <<: *default

    production:
      <<: *default

Once this is done, you should be able to go to */twitter* on your app and the LTI app will appear.
