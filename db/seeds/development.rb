# frozen_string_literal: true

%w[Personal Work Rest].each { |category| Category.find_or_create_by!(name: category) }
