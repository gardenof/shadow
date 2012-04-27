require 'spec_helper'

describe GameSettingsController do
  include BilgePump::Specs

  model_class GameSetting

  def attributes_for_create
    { name: 'create'}
  end

  def attributes_for_update
    { name: 'update' }
  end

end