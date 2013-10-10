module Drupal
  class User < Base
    self.primary_key = "uid"

    has_many :sessions, :foreign_key => "sid", :class_name => "Drupal::Session"
    has_and_belongs_to_many :profile_fields, :class_name => "Drupal::ProfileField", :join_table => "profile_values", :foreign_key => "uid", :association_foreign_key => "fid"
    serializes "data"

    # Authenticate a user given a name and password. For example:
    #
    #   if user = Drupal::User.authenticate("bob", "flibble")
    #     # At this point, we have a valid user record
    #   else
    #     # Could be an invalid user/password combo or the user might be blocked
    #   end
    def self.authenticate(name, password)
      where(:name => name, :status => 1, :password => Digest::MD5.hexdigest(password)).first
    end

    # Returns true if the user is allowed to login.
    def active?
      status == 1
    end

    # Returns true if the user has been barred from logging in.
    def blocked?
      !active?
    end

    # Returns true if the user is the system administrator account.
    def administrator?
      uid == 1
    end
  end
end
