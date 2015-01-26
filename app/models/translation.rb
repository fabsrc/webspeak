class Translation < ActiveRecord::Base
  belongs_to :words
  belongs_to :translation, class_name: 'Word'
end
