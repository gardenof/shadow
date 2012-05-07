require 'spec_helper'

describe GameAssetsController do
  include BilgePump::Specs only: [:index, :show, :create, :edit, :update, :destroy]

  model_class GameAsset

  render_views

  def attributes_for_create
    {name: "create"}
  end

  def attributes_for_update
    {name: "update"}
  end

end