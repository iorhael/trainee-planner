# frozen_string_literal: true

RSpec.shared_context 'with cassette' do |cassette_name|
  around do |example|
    VCR.use_cassette(cassette_name) do
      cassette_record_time = VCR.current_cassette.originally_recorded_at
      Timecop.freeze(cassette_record_time || DateTime.now) do
        example.run
      end
    end
  end
end
