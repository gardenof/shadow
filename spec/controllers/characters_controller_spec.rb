require 'spec_helper'

describe CharactersController do
  include BilgePump::Specs
  render_views

  def attributes_for_create
    {name: "create"}
  end

  def attributes_for_update
    {name: "update"}
  end

end