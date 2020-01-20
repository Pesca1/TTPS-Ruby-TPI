module Tokenable
  extend ActiveSupport::Concern
  class_methods do
    def generate_token
      [*('a'..'z'),*('0'..'9')].shuffle[0,50].join
    end
  end
end