# frozen_string_literal: true

class SearchService
  def initialize(search_params:, default_relation:)
    @search_params = search_params
    @default_relation = default_relation
  end

  def call
    return default_relation if search_params.empty?

    module_name::SearchQuery.new(search_params:, relation: default_relation).call
  end

  private

  attr_reader :search_params, :default_relation

  def module_name
    default_relation.model.to_s.pluralize.constantize
  end
end
