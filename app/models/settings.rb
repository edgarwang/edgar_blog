class Settings < SettingsLogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
end
