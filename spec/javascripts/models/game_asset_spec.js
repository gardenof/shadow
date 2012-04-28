(function() {

  describe("GameAsset", function() {
    return describe("total", function() {
      it("is product of price and amount", function() {
        var asset;
        asset = new GameAsset({
          price: 2,
          amount: 4
        });
        return expect(asset.total()).toBe(8);
      });
      return it("handles nulls", function() {
        var asset;
        asset = new GameAsset({
          amount: 4
        });
        expect(asset.total()).toBe(void 0);
        asset = new GameAsset({
          price: 2
        });
        return expect(asset.total()).toBe(void 0);
      });
    });
  });

}).call(this);
