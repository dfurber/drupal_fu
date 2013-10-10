module Drupal
  class Session < Base
    self.primary_key = "sid"
    belongs_to :user, :foreign_key => "uid", :class_name => "Drupal::User"

    def self.authenticate(sid)
      where(:sid => sid, :status => 1).includes(:user).first
    end

    def session
      @unserialized_session ||= decode(super || "")
    end
    
    def session=(new_value)
      @unserialized_data = new_value
      super encode(new_value)
    end

    private
    
      def encode(data)
        result = ""
        data.each { |key, value| result << key << "|" << Drupal::Serialize.serialize(value) }
        result
      end
    
      def decode(data)
        result = {}
        vars = data.split(/([a-zA-Z0-9]+)\|/)
        vars.shift
        vars.each_slice(2) { |pair| result[pair.first] = Drupal::Serialize.unserialize(pair.last) }
        result
      end
  end
end
