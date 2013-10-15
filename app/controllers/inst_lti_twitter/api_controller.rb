require_dependency "inst_lti_twitter/application_controller"
require 'twitter'
require 'ims/lti'

module InstLtiTwitter
  class ApiController < ApplicationController

    def tweets
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["INST_LTI_TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["INST_LTI_TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["INST_LTI_TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["INST_LTI_TWITTER_ACCESS_TOKEN_SECRET"]
      end
      max = params[:max] || 10
      tweets = []
      if params[:hashtag].present?
        tweets = client.search("##{params[:hashtag]}", count: max, result_type: "recent")
      elsif params[:username].present?
        tweets = client.user_timeline(params[:username], count: max, result_type: "recent")
      end
      render json: tweets
    end

    def embed
      tp = IMS::LTI::ToolProvider.new(nil, nil, params[:launch_params])
      tp.extend IMS::LTI::Extensions::Content::ToolProvider

      title, url = generate_url(params)
      width = 500
      height = 530
      redirect_url = build_url(tp, title, url, width, height)

      if redirect_url.present?
        render json: { redirectUrl: redirect_url }
      else
        render json: {
          url: url,
          title: title,
          width: width,
          height: height
        }
      end
    end

  private

    def generate_url(params)
      url = root_url
      if params[:hashtag].present?
        title = "##{params[:hashtag]}"
        url += "?hashtag=#{params[:hashtag]}"
      else
        title = "@#{params[:username]}"
        url += "?username=#{params[:username]}"
      end
      url += "&embedded=1"
      url += "&max=#{params[:max] || 10}"
      title = "Twitter: #{title}"
      [title, url]
    end

    def build_url(tp, title, url, width, height)
      if tp.accepts_content?
        if tp.accepts_iframe?
          redirect_url = tp.iframe_content_return_url(url, width, height, title)
        elsif tp.accepts_url?
          redirect_url = tp.url_content_return_url(url, title)
        elsif tp.accepts_lti_launch_url?
          redirect_url = tp.lti_launch_content_return_url(url, title, title)
        end
        return redirect_url
      end
    end

  end
end
