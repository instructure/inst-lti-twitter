require 'spec_helper'

module InstLtiTwitter
  describe ApiController do

    describe "GET xml_config" do
      before :each do
        request.stub(:env).and_return({
            "SCRIPT_NAME"     => "/twitter_lti",
            "rack.url_scheme" => "http",
            "HTTP_HOST"       => "test.host",
            "PATH_INFO"       => "/twitter_lti"
        })
      end

      it "include title, text, tool_id and icon_url" do
        get :xml_config, use_route: :inst_lti_twitter
        expect(response.body).to include('<blti:title>Twitter</blti:title>')
        expect(response.body).to include('<lticm:property name="text">Twitter</lticm:property>')
        expect(response.body).to include('<lticm:property name="tool_id">twitter_lti</lticm:property>')
        expect(response.body).to include('<lticm:property name="icon_url">http://test.host/assets/inst_lti_twitter/icon.png</lticm:property>')
      end
    end

    describe "GET health_check" do
      it "returns 200" do
        get :health_check, use_route: :lti_redirect_engine
        expect(response.code.to_i).to be(200)
      end
    end
  end
end
