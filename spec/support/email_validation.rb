class EmailValidation < Validacity::BaseValidation
  validates :email,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
              message: "email format invalid"
            }
end
