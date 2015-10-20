require 'active_record'

class Person < ActiveRecord::Base
  belongs_to :mother, :class_name => 'Person'
  belongs_to :father, :class_name => 'Person'

  def grandparents
    grands = []
    grands<<mother().mother()
    grands
end
