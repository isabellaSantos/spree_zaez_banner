module SpreeZaezBanner
  class Engine < Rails::Engine
    require 'spree/core'
    engine_name 'spree_zaez_banner'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_zaez_banner.preferences', :before => :load_config_initializers do |app|
      Spree::BannerConfig = Spree::BannerConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
