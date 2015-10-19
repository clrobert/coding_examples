class Forgiver < String
  def method_missing(name, *args, &block)
    self
  end
end
