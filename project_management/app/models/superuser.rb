class Superuser < User
  def self.model_name
    User.model_name
  end
end
