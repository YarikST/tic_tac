require './call_present_exception'
require './move_type_exception'
require './move_types'
require './player'
require './winner_types'
require './board'
require 'io/console'

class Engine

  attr_reader :board

  def initialize(board)
    self.board = board
  end

  def run
    p "Розпочнемо гру!!!"
    loop do
      begin
        input_call_position= nil
        input_call_move_type= nil

        loop do
          p "Уведіть цифру від 1 до #{self.board.size}"
          input_call_position = STDIN.getch.to_i

          if input_call_position < 1 || input_call_position > self.board.size
            p "Не вірно"
          else
            break;
          end
        end

        loop do
          p "Уведіть тип(X, 0)"
          input_call_move_type = STDIN.getch

          if input_call_move_type.downcase != "x" && input_call_move_type != "0"
            p "Не вірно"
          else
            break;
          end
        end

        board.make_move input_call_position - 1 , input_call_move_type == "0" ? MoveTypes::ZERO : MoveTypes::CRISS_CROSS

        games_completed = board.games_completed

        if games_completed.nil?
          p "Наступний хід\n"
          board.show
        elsif games_completed == WinnerTypes::SINGLE
          p "Ура в нас є переможець(#{board.combination_completed})"
          board.show
          break
        elsif games_completed == WinnerTypes::MULTI
          board.show
          p "Вітаємо виграли обоє гравців"
          break
        end

      rescue Exception => boom
        p boom.message
      end
    end
  end

  private
  attr_writer :board

end