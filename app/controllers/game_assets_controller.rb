class GameAssetsController < ApplicationController
  # GET /game_assets
  # GET /game_assets.json
  def index
    @game_assets = GameAsset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_assets }
    end
  end

  # GET /game_assets/1
  # GET /game_assets/1.json
  def show
    @game_asset = GameAsset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_asset }
    end
  end

  # GET /game_assets/new
  # GET /game_assets/new.json
  def new
    @character  = Character.find(params[:character_id])
    @game_asset = GameAsset.new
  

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_asset }
    end
  end

  # GET /game_assets/1/edit
  def edit
    @game_asset = GameAsset.find(params[:id])
    
    
  end

  # POST /game_assets
  # POST /game_assets.json
  def create
     @game_asset = GameAsset.new(params[:game_asset])

    respond_to do |format|
      if @game_asset.save
        format.html { redirect_to character_path(@game_asset.character_id), notice: 'Game asset was successfully created.' }
        format.json { render json: @game_asset, status: :created, location: @game_asset }
      else
        format.html { render action: "new" }
        format.json { render json: @game_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_assets/1
  # PUT /game_assets/1.json
  def update
    @game_asset = GameAsset.find(params[:id])

    respond_to do |format|
      if @game_asset.update_attributes(params[:game_asset])
        format.html { redirect_to character_path(@game_asset.character), notice: 'Game asset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_assets/1
  # DELETE /game_assets/1.json
  def destroy
    @game_asset = GameAsset.find(params[:id])
    @game_asset.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@game_asset.character) }
      format.json { head :ok }
    end
  end

  def total
    player = GameAsset.new
    @total=player.sum
  end

end
