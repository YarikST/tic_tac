class MoveTypeException < StandardError

  def initialize(msg="Помилка. Очікується інший тип ходу")
    super
  end

end