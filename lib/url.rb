class Url
  attr_accessor :url

  def initialize url
    @url = url
  end

  def simplify
    @url =~ Regexp.new('.+/\d+')
    @url =~ Regexp.new('.+/product/[A-Z0-9]+') if @url.include? 'amazon'
    $&
  end
end
