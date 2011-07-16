class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :admin
  
  has_many :base_roms, :foreign_key => 'uploader_id'
  
  validates :name, :presence => true, :uniqueness => true

  def owns_rom base_rom
    base_rom.uploader == self
  end
end
