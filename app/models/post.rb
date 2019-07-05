class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.title
      unless record.title.match(Regexp.union(["Won't Believe", "Secret", "Top [number]", "Guess"]))
        record.errors[:title] << 'Need a name including X please!'
      end
    end
  end
end


class Post < ActiveRecord::Base

  validates :title, presence: true
  validates(:content, { :length => { :minimum => 250 } })
  validates(:summary, { :length => { :maximum => 250 } })
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  include ActiveModel::Validations
  validates_with MyValidator

end
