# frozen_string_literal: true

module FlashHelper
  BOOTSTRAP_ALERT_CLASS = {
    success: 'alert-success',
    notice: 'alert-info',
    info: 'alert-info',
    warn: 'alert-warning',
    alert: 'alert-danger',
    error: 'alert-danger'
  }.freeze

  def flash_class(level)
    BOOTSTRAP_ALERT_CLASS[level.to_sym]
  end
end
