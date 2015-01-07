require 'rubygems'
require 'active_model'
class Active
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  include ActiveModel::Serializers::JSON
  include Tire::Model::Search

  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = attributes
  end
end
