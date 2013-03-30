class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  protected
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # this is not the best way to do this, but for now it gets devise working,
  # without having to override the controller
  def sanitize_for_mass_assignment(attributes)
    attributes=attributes.permit(:email, :password, :password_confirmation, :remember_me)
    super(attributes)
  end
end
