# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class CharactersControllerTest < ActionDispatch::IntegrationTest
      test "should get index" do
        get api_v1_characters_url

        assert_response :success
      end
    end
  end
end
