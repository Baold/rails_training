class Job < ApplicationRecord
    belongs_to :created_by, class_name: 'User'
    enum status: {
        draft: 0,
        publish: 1
    }
    validates :title, 
                presence: true
    validates :salary_from, 
                numericality: { only_integer: true }, 
                allow_blank: true
    validates :salary_to, 
                comparison: { greater_than: :salary_from },
                numericality: { only_integer: true },
                allow_blank: true
end