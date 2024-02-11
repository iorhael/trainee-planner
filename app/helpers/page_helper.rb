# frozen_string_literal: true

module PageHelper
  def record_index_with_pagination(index:, relation_class:)
    index + 1 + ((params.fetch(:page, 1).to_i - 1) * params.fetch(:per_page, relation_class.default_per_page).to_i)
  end
end
