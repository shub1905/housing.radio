OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1526306647604884", "ac6962ad8e1bcfff2233510435a95b50"
end