class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_save { self.role ||= :stu }

  has_many :projects
  has_many :groupings
  has_many :groups, through: :groupings

  before_create :generate_auth_token

  validates :username, 
  					length: { minimum: 3, maximum: 16 },
            uniqueness: { case_sensitive: false }, 
  					presence: true
  validates :first_name,
  					length: { minimum: 2, maximum: 20 }, 
  					presence: true
  validates :last_name,
  					length: { minimum: 2, maximum: 20 }, 
  					presence: true
  validates :grad_year, 
            length: { is: 4 },
            allow_blank: true
  validates :school, 
            length: { minimum: 3, maximum: 30 },
            allow_blank: true
  validates :phone_number, 
  					length: {is: 10 },
            allow_blank: true

  enum role: [:stu, :edu, :par, :admin]

  def generate_auth_token
    loop do
      self.auth_token = SecureRandom.base64(64)
      break unless User.find_by(auth_token: auth_token)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
