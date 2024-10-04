class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties or /properties.json
  def index
    if params[:search].present?
      @properties = Property.where('address LIKE ? OR city LIKE ? OR state LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @properties = Property.all
    end

    @properties = @properties.paginate(page: params[:page], per_page: 10)
  end

  # GET /properties/1 or /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    if @property.destroy
      respond_to do |format|
        format.html { redirect_to properties_path, notice: 'Property was successfully deleted.' }
        format.json { render json: { status: 'success' }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to properties_path, alert: 'Failed to delete the property.' }
        format.json { render json: { status: 'error', message: 'Failed to delete the property' }, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:address, :city, :state)
    end
end
