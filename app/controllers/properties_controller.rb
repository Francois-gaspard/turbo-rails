class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @properties = pagy(Property.order(id: :asc), items: 5)
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      respond_to do |format|
        format.html { redirect_to properties_path, notice: "Property was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      respond_to do |format|
        format.html { redirect_to properties_path, notice: "Property was successfully updated." }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_path,
                                notice: "Property was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name)
  end
end
