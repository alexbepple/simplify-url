class Url
  attr_accessor :url

  def initialize url
    @url = url
  end

  def simplify
    @url =~ Regexp.new('http://lifehacker.com/\d+')
    $&
  end
end
