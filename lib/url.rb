class Url
  attr_accessor :url

  def initialize url
    @url = url
  end

  def simplify
    if @url.include? 'utm_source'
      @url =~ Regexp.new('(.+)/\?utm_source')
      return Regexp.last_match(1)
    end
    @url =~ Regexp.new('.+/\d+')
    @url =~ Regexp.new('.+/product/[A-Z0-9]+') if @url.include? 'amazon'
    $&
  end
end
