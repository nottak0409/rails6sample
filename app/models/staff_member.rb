class StaffMember < ApplicationRecord
    include StringNormalizer
    include PersonalNameHolder
    has_many :events, class_name: "StaffEvent", dependent: :destroy

    before_validation do
        self.email = normalize_as_email(email)
    end

    validates :email, presence: true, "valid_email_2/email": true,
        uniqueness: { case_sensitive: false }

    def password=(raw_password)
        if raw_password.kind_of?(String)
            self.hashed_password = BCrypt::Password.create(raw_password)
        elsif raw_password.nil?
            self.hashed_password = nil
        end
    end

    def active?
        !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today )
    end
end
