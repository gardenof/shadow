class CommlinksController < ApplicationController

  def index
    @commlinks = Commlink.all
    respond_to do |format|
      format.json { render json: @commlinks }
    end
  end

  def show
    @commlink = Commlink.find(params[:id])
    respond_to do |format|
      format.json { render json: @commlink }
    end
  end

  def create
    respond_to do |format|
      if (@commlink = Commlink.create(params[:commlink]))
        format.json { render json: @commlink  }
      else
        format.json do
          render json: @commlink.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @commlink = Commlink.find(params[:id])

    respond_to do |format|
      if @commlink.update_attributes(params[:commlink])
        format.json { render json: @commlink }
      else
        format.json do
          render json: @commlink.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end
end