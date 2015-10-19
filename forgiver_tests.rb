require 'minitest/autorun'
require './forgiver'

class ForgiverTest < Minitest::Test
  def setup
    @object = Forgiver.new("string")
  end
 
  def test_simple_return
    assert @object.upcase === "STRING"
  end

  def test_single_invalid_method
    # This should return the original argument
    assert @object.sup === "string"
  end

  def test_invalid_method_after_valid_method
    assert @object.upcase.noop === "STRING"
  end

  def test_mix_of_valid_and_invalid_methods
    assert @object.noop.noop.upcase.noop.downcase === "string"
  end

  def test_many_invalid_methods
    assert @object.sup.dog.hi === "string"
  end

  def test_many_valid_methods
    assert @object.upcase.chop.length.to_s === "5"
  end
end
