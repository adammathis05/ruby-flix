class Movie < ApplicationRecord

  def flop?
    total_gross.blank? || total_gross <= 2_000_000
  end

end