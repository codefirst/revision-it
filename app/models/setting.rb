class Setting < Settingslogic
  source(Rails.root + 'config/revision-it.yml')
  namespace Rails.env
end
