class CallPresentException < StandardError

  def initialize(msg="Помилка. Клітинка зайнята")
    super
  end

end