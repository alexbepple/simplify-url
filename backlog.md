
for mass factory methods : Rule → Rules

stub rules

Can I do better than this?
  def apply input
    result = input
    @rules.each { |rule| result = rule.apply(result) }
    result
  end
