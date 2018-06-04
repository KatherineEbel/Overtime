class Post < ApplicationRecord
  validates_presence_of :rationale, :date
end
