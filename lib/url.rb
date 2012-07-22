class Url
  attr_accessor :url

  def initialize url
    @url = url
  end

  def simplify
    @url =~ Regexp.new('.+/\d+')
    $&
  end
end
