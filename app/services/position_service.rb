# frozen_string_literal: true

module Service
  class PositionService
    def initialize(list)
      @list = list
    end

    def change_position(position)
      time = list.length
      if position == -1
        time.times do
          @list[time - 1] = @list[time]
        end
      elsif position == 1
        time.times do
          @list[time] = @list[time + 1]
        end
      end
      @list
    end
  end
end
