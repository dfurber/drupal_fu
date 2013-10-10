module Drupal
  class Variable < Base
    self.table_name = "variable"
    self.primary_key = "name"
    serializes "value"

    def self.value_of(name)
      if variable = where(:name => name)
        variable.value
      end
    end
  end
end
