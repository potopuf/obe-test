# frozen_string_literal: true

module Api
  module V1
    class CharactersController < ApiController
      def index
        data = GetCharactersService.new.call(filter_params, params[:page])

        render json: data, status: :ok
      end

      private

      def filter_params
        @filter_params = params.slice(*Character.search_scopes)
      end
    end
  end
end
