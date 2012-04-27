require 'spec_helper'

describe GameSetting do
  describe "validation" do
    it "requires name" do
      GameSetting.new(name: nil).should_not be_valid
    end
  end

  describe "associated characters" do
    let (:setting) { Factory :game_setting }
    let (:setting2) { Factory :game_setting }

    it "are available by join" do
      pc1 = Factory(:character, game_setting_id: setting.id)
      pc2 = Factory(:character, game_setting_id: setting.id)
      pc3 = Factory(:character, game_setting_id: setting2.id)

      setting.characters.should include pc1, pc2
      setting.characters.should_not include pc3

      setting2.characters.should_not include pc1, pc2
      setting2.characters.should include pc3
    end
  end
end