class Parameter < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :history

    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, uniqueness: true
end
