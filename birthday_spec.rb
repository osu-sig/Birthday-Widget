require 'spec_helper'
require_relative '../../models/birthday'

describe Birthday do
  subject { Birthday }
  its(:ancestors) { is_expected.to include(Base) }


  context 'using stubs', functional: true do
    describe 'after #initialization' do
      config = { 'birthdays' => [{ 'name' => 'Bob', 'date' => '01-26' }] }
      # Remember to deep_dup when using variable names! Otherwise stuff WILL BLEED OVER
      # Your other choice is to not use a variable name, and just use a literal.
      before { with_config(config.deep_dup) }
      let(:birthday) { Birthday.new }

      describe '@days_advanced_notice' do
        subject { birthday.instance_variable_get(:@days_advanced_notice) }
        it { is_expected.to be >= 0 }
        it { is_expected.to be_integer }
      end

      describe '@birthdays' do
        subject { birthday.instance_variable_get(:@birthdays) }
        its(:length) { is_expected.to eq 1 }
      end
    end


    describe '#get_upcoming_birthday' do
      def get_result(date, days_advanced_notice = 7)
        with_config('birthdays' => [{ 'name' => 'Bob', 'date' => date.strftime("%m-%d") }])
        birthday = Birthday.new
        birthday.instance_variable_set(:@days_advanced_notice, days_advanced_notice)
        birthday.get_upcoming_birthday
      end

      def enforce!(date, days_advanced_notice = 7)
        expect(get_result(date, days_advanced_notice)).to eq('name' => 'Bob',
                                                             'date' => date.to_time)
      end

      it 'returns birthdays today' do
        enforce!(Date.today)
      end

      it 'returns birthdays on @days_advanced_notice' do
        days_advanced_notice = 7
        date = Date.today.next_day(days_advanced_notice)
        enforce!(date)
      end

      it 'returns birthdays before @days_advanced_notice' do
        days_advanced_notice = 7
        date = Date.today.next_day(days_advanced_notice - 1)
        enforce!(date, days_advanced_notice)
      end

      it 'returns only one birthday' do
        today = Date.today
        with_config('birthdays' => [{ 'name' => 'Bob', 'date' => today.strftime("%m-%d") },
                                    { 'name' => 'Frank', 'date' => today.strftime("%m-%d") }])
        result = Birthday.new.get_upcoming_birthday
        expect(result).to eq('name' => 'Bob', 'date' => today.to_time)
      end

      it 'does not return birthdays after @days_advanced_notice' do
        days_advanced_notice = 7
        date = Date.today.next_day(days_advanced_notice + 1)
        expect(get_result(date, days_advanced_notice)).to be_blank
      end

      it 'does not return birthdays before today' do
        expect(get_result(Date.today.prev_day)).to be_blank
      end
    end
  end



  context 'using live data', live: true do
    let(:birthday) { Birthday.new }

    describe '@birthdays' do
      let(:birthdays) { birthday.instance_variable_get(:@birthdays) }
      subject { birthdays }
      its(:length) { is_expected.to be >= 1 }

      its 'entries contain valid date and name values' do
        birthdays.each do |entry|
          expect(entry.keys).to include('date', 'name')
          expect(entry['date'].class).to eq Date
          expect(entry['name'].class).to eq String
        end
      end
    end


    # This test is not awesome, since it may or may not return the structure we want.
    # It does however call most of the code, so it still has value.
    describe 'get_upcoming_birthday' do
      it 'gets an upcoming birthday' do
        response = birthday.get_upcoming_birthday
        expect([Hash, NilClass]).to include(response.class)

        if response.class == Hash
          expect(response['date'].class).to eq Time
          expect(response['name']).to_not be_blank
        end
      end
    end
  end
end