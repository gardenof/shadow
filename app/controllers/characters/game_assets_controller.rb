module Characters
  class GameAssetsController < ApplicationController
    include BilgePump::Controller

    model_scope [:character]
    model_class GameAsset

  end
end
