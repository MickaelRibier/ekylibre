class CropsController < ApplicationController
  before_action :set_crop, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @crops = Crop.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @crop = Crop.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @crop = Crop.new(crop_params)

    respond_to do |format|
      if @crop.save
        format.html { redirect_to @crop, notice: "Crop was successfully created." }
        format.json { render :show, status: :created, location: @crop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @crop.update(crop_params)
        format.html { redirect_to @crop, notice: "Crop was successfully updated." }
        format.json { render :show, status: :ok, location: @crop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @crop.destroy
    respond_to do |format|
      format.html { redirect_to crops_url, notice: "Crop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crop
      @crop = Crop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crop_params
      params.require(:crop).permit(:title, :content, :work_number, :shape)
    end
end
