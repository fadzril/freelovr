class SprocketsController < ActionController::Base
  caches_page :show, :if => Proc.new { Rails.configuration.action_controller.perform_caching }
  
  def show
    sprocket = Sprocket.new(params[:id])
    render :text => sprocket.source, :content_type => "text/javascript"
  end
end
