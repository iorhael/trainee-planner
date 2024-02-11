# frozen_string_literal: true

module ViewsImageHelper
  PART_OF_DAY = {
    0...6 => 'night',
    6...12 => 'morning',
    12...18 => 'day',
    18...24 => 'evening'
  }.freeze

  def part_of_day_image_path
    "landscapes/#{PART_OF_DAY.select { |part| part.include?(DateTime.now.hour) }.values.first}"
  end
end
