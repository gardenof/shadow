class GameAssetsController < ApplicationController
  include BilgePump::Controller

  model_class GameAsset


  def new
    @character = Character.find(params[:id])
    @game_asset = GameAsset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_asset }
    end
  end

  def update
    @game_asset = GameAsset.find(params[:id])

    respond_to do |format|
      if @game_asset.update_attributes(params[:game_asset])
        format.html { redirect_to @game_asset, notice: 'Asset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_asset.errors, status: :unprocessable_entity }
      end
    end
  end
end
