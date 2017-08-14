class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
    
end
