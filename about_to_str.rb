require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutToStr < Neo::Koan

  class CanNotBeTreatedAsString
    def to_s
      "non-string-like"
    end
  end

  def test_to_s_returns_a_string_representation
    not_like_a_string = CanNotBeTreatedAsString.new
    assert_equal "non-string-like", not_like_a_string.to_s
  end

  def test_normally_objects_cannot_be_used_where_strings_are_expected
    assert_raise(TypeError) do
      File.exist?(CanNotBeTreatedAsString.new)
    end
  end

  # ------------------------------------------------------------------

  class CanBeTreatedAsString
    def to_s
      "string-like"
    end

    def to_str
      to_s
    end
  end


  # I thought that the to_s method was just a simple toString method 
  # but apparently its not a strict one. Ruby supports a to_str method 
  # but the difference isn't always so clear. The to_s isn't a strict
  # conversion but to_str is. So only use to_str when you know that 
  # object can be used everywhere a String can.
  # http://briancarper.net/blog/98/

  # [to_i and to_s] are not particularly strict: if
  # an object has some kind of decent representation as a string, 
  # for example, it will probably have a to_s method... 

  # [to_int and to_str] are strict conversion functions: 
  # you implement them only if you object can naturally be used 
  # every place a string or an integer could be used.

  # print, puts and string interpolation use to_s. 
  # Mostly everything else (glob, split, match, string concatenation) 
  # uses to_str.
  # Defining to_str will NOT define to_s for you, and vice versa. 
  # Going by the vague intuitive descriptions given above, 
  # I'd almost have expected methods that use to_s to know enough to fall 
  # back to using to_str.

  def test_to_str_also_returns_a_string_representation
    like_a_string = CanBeTreatedAsString.new
    assert_equal "string-like", like_a_string.to_str
  end

  def test_to_str_allows_objects_to_be_treated_as_strings
    assert_equal false, File.exist?(CanBeTreatedAsString.new)
  end

  # ------------------------------------------------------------------

  def acts_like_a_string?(string)
    string = string.to_str if string.respond_to?(:to_str)
    string.is_a?(String)
  end

  def test_user_defined_code_can_check_for_to_str
    assert_equal false, acts_like_a_string?(CanNotBeTreatedAsString.new)
    assert_equal true,  acts_like_a_string?(CanBeTreatedAsString.new)
  end
end
