class UnitForBuildingController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin_or_dnd_staff!
  include PjaxModalController
  
  def new
    @buildings = building_scope
    @units = []
  end
  def create
    if @unit = unit_source.create(unit_params)
      flash[:notice] = "Unit <strong>#{@unit[:name]}</strong> in <a href=\"#{building_path(@unit.building)}\">#{@unit.building.name}</a> was successfully created."
      redirect_to program_sub_program_vouchers_path(program_id: params[:program_id].to_i, sub_program_id: params[:sub_program_id].to_i)
    else
      flash[:error] = "Unable to add unit"
    end
  end

  private
    def unit_scope
      unit_source.all
    end

    def unit_source
      Unit
    end

    def building_scope
      Building.all
    end
    
    # Only allow a trusted parameter "white list" through.
    def unit_params
      params.require(:unit_for_building).permit(:name, :available, :building_id)
    end
end