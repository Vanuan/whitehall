class Admin::WorldLocationsController < Admin::BaseController
  before_filter :load_world_location, only: [:edit, :update, :show, :features]

  def index
    @active_world_locations, @inactive_world_locations = WorldLocation.ordered_by_name.partition { |wl| wl.active? }
  end

  def update
    if @world_location.update_attributes(params[:world_location])
      redirect_to [:admin, @world_location], notice: "World location updated successfully"
    else
      render action: :edit
    end
  end

  def features
    @feature_list = @world_location.load_or_create_feature_list(params[:locale])

    filter_params = default_filter_params
      .merge(params.slice(:page, :type, :world_location, :title).symbolize_keys)
      .merge(state: 'published')
    @filter = Admin::EditionFilter.new(Edition, current_user, filter_params)
    @featurable_topical_events = []
  end

  private

  def default_filter_params
    {
      world_location: @world_location.id
    }
  end

  def load_world_location
    @world_location = WorldLocation.find(params[:id] || params[:world_location_id])
  end
end
