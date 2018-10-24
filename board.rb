require './call'
require './call_present_exception'
require './move_type_exception'
require './move_types'
require './player'
require './winner_types'

class Board

  attr_accessor :players
  attr_accessor :calls
  attr_accessor :call_size
  attr_accessor :winning_combination
  attr_accessor :last_move_type

  def initialize(players:[], call_size: 3)
    self.players = players
    self.call_size = call_size
    self.calls = []
    self.winning_combination = []

    call_size.times do |x|
      call_size.times do |y|
        self.calls.push(Call.new(x*call_size+y))
      end
    end

    call_size.times do |x|
      mas = []

      call_size.times do |y|
        mas.push x*call_size+y
      end

      winning_combination << mas
    end

    call_size.times do |x|
      mas = []

      call_size.times do |y|
        mas.push y*call_size+x
      end

      winning_combination << mas
    end

    winning_combination << [0, (call_size-1)**2, ((call_size-1) * call_size) + (call_size-1)]
    winning_combination << [call_size-1, (call_size-1)**2, call_size*(call_size-1)]

    call_size.times do |x|
      mas = []

      call_size.times do |y|
        mas.push y*call_size+x
      end

      winning_combination << mas
    end

  end

  def make_move position, move_type

    if move_type==last_move_type
      raise MoveTypeException
    end

    # call = get_call x, y
    call = self.calls[position]

    unless call.move_type.nil?
      raise CallPresentException
    end

    self.last_move_type = move_type
    call.move_type = move_type
  end

  def games_completed
    if self.combination_completed
      return WinnerTypes::SINGLE
    elsif self.calls.all?{|call|!call.move_type.nil?}
      return WinnerTypes::MULTI
    else
      return nil
    end
  end

  def combination_completed
    self.winning_combination.detect do |combination|
      combination.all?{|i|self.calls[i].move_type == MoveTypes::CRISS_CROSS} || combination.all?{|i|self.calls[i].move_type == MoveTypes::ZERO}
    end
  end

  def show
    board = ""

    (self.call_size).times do |i|
      board+="|"
      (self.call_size).times do |j|
        if self.calls[i*self.call_size+j].move_type == MoveTypes::CRISS_CROSS
          board+='X'
        elsif self.calls[i*self.call_size+j].move_type == MoveTypes::ZERO
          board+='0'
        else
          board+= ' '
        end

        if j !=self.call_size-1
          board+=' '
        end

      end
      board += "|\n"
    end

    puts board + "\n\n\n"
  end

  def size
    self.call_size**2
  end

  private
  def get_call x, y
    self.calls[x*self.call_size+y]
  end

end