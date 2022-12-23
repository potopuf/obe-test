# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    @search_scopes ||= []
  end

  module ClassMethods
    attr_reader :search_scopes

    def search_scope(name, *args)
      scope "filter_by_#{name}", *args
      @search_scopes << name
    end
  end
end
