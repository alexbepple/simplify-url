class SubstitutionRule
  def initialize(criterion, to_replace, replace_with)
    @criterion = criterion
    @to_replace = to_replace
    @replace_with = replace_with
  end

  def apply(input)
    return input unless input.match(@criterion)
    return input.sub(@to_replace, @replace_with)
  end

end

