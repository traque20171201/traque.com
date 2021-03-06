class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  enum tradingType: {buy: 1, sell: 2}
  validates :tradingDate, :tradingType, :volume, :price, presence: true

  delegate :code, to: :stock, allow_nil: true

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end
end
