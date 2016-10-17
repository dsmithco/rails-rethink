class Formable < ApplicationRecord
  belongs_to :form
  belongs_to :formable, :polymorphic => true, touch: true
end
