class PostTitleValidator < ActiveModel::Validator

    CLICKBAIT_PATTERNS = [
        /Won't Believe/,
        /Secret/,
        /Top [\d*]/,
        /Guess/
    ]

    def record_not_clickbaity(record)
        CLICKBAIT_PATTERNS.none? { |pat| pat.match(record.title) }
    end


    def validate(record)
        if record_not_clickbaity(record)
            record.errors[:title] << "This title isn't tempting enough!!!"
        end
    end
end

class Post < ActiveRecord::Base
    include ActiveModel::Validations
    validates :title, presence: :true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validates_with PostTitleValidator
end
