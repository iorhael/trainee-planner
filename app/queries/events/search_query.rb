# frozen_string_literal: true

module Events
  class SearchQuery
    def initialize(search_params:, relation:)
      @search_params = search_params
      @relation = relation
    end

    def call
      containing_name if search_params[:name]
      with_category if search_params[:category_name]
      relation
    end

    private

    attr_reader :relation, :search_params

    def containing_name
      @relation = relation.where('events.name like ?', "%#{search_params[:name]}%")
    end

    def with_category
      @relation = relation.eager_load(:category).where({ categories: { name: search_params[:category_name] } })
    end
  end
end
