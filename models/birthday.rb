require 'date'
require_relative 'base'

class Birthday < Base
  def initialize
    super
    @birthdays = parse_birthdays
    @days_advanced_notice = 7
  end



  # Returns the first birthday occuring within the next @days_advanced_notice days, or nil if none.
  def get_upcoming_birthday
    today = Date.today

    @birthdays.each do |birthday|
      diff = birthday['date'] - today
      if diff >= 0 && diff <= @days_advanced_notice
        birthday['date'] = birthday['date'].to_time
        return birthday
      end
    end

    nil
  end



  private

  # Returns parsed data structure for birthdays
  def parse_birthdays
    birthdays = @config['birthdays'].map do |birthday|
      birthday['date'] = Date.strptime(birthday['date'], '%m-%d')
      birthday
    end

    birthdays.sort_by { |entry| entry['date'] }
  end
end