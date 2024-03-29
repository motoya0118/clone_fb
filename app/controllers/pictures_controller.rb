class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
  end

  # GET /pictures/1/edit
  def edit
    ban_deferrent_user
  end

  # POST /pictures or /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    respond_to do |format|
      if @picture.save
        format.html { redirect_to pictures_path, notice: "Picture was successfully created." }
        format.json { render :index, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    flag = ban_deferrent_user
    if flag
      @picture.destroy

      respond_to do |format|
        format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def ban_deferrent_user
       unless @picture.user_id == current_user.id
         redirect_to pictures_path, notice: "Different User"
         return false
       else
         return true
       end
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:image, :content,:image_cache)
    end
end
