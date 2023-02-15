class StaffMember < ApplicationRecord
    include EmailHolder
    include PersonalNameHolder
    include PasswordHolder
    has_many :events, class_name: "StaffEvent", dependent: :destroy

    def active?
        !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today )
    end
end
