(function() {

  describe("Character", function() {
    beforeEach(function() {
      GameAsset.collection.reset();
      return GameExpense.collection.reset();
    });
    describe("assets", function() {
      it("includes assets matching id", function() {
        var asset, character;
        character = new Character({
          id: 1
        });
        asset = new GameAsset({
          character_id: character.id
        });
        GameAsset.collection.add(asset);
        return expect(character.assets()).toContain(asset);
      });
      return it("doesn't include asset for another character", function() {
        var asset, character;
        character = new Character({
          id: 1
        });
        asset = new GameAsset({
          character_id: 2
        });
        GameAsset.collection.add(asset);
        return expect(character.assets()).not.toContain(asset);
      });
    });
    describe("assetTotal", function() {
      return it("is total of character's assets", function() {
        var character;
        character = new Character({
          id: 1
        });
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          price: 2,
          amount: 3
        }));
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          price: 4,
          amount: 2
        }));
        return expect(character.assetTotal()).toBe(14);
      });
    });
    describe("expenses", function() {
      it("includes expenses matching id", function() {
        var character, expense;
        character = new Character({
          id: 1
        });
        expense = new GameExpense({
          character_id: character.id
        });
        GameExpense.collection.add(expense);
        return expect(character.expenses()).toContain(expense);
      });
      return it("doesn't include expense for another character", function() {
        var character, expense;
        character = new Character({
          id: 1
        });
        expense = new GameExpense({
          character_id: 2
        });
        GameExpense.collection.add(expense);
        return expect(character.expenses()).not.toContain(expense);
      });
    });
    describe("expenseTotal", function() {
      return it("is total of character's expenses", function() {
        var character;
        character = new Character({
          id: 1
        });
        GameExpense.collection.add(new GameExpense({
          character_id: character.id,
          price: 2
        }));
        GameExpense.collection.add(new GameExpense({
          character_id: character.id,
          price: 4
        }));
        return expect(character.expenseTotal()).toBe(6);
      });
    });
    return describe("legalStatus", function() {
      it("is public when character has no assets", function() {
        var character;
        character = new Character({
          id: 1
        });
        return expect(character.legalStatus()).toBe("Public");
      });
      it("is restricted if restricted asset is equipped", function() {
        var character;
        character = new Character({
          id: 1
        });
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          equipped: true,
          legality: 'Restricted'
        }));
        return expect(character.legalStatus()).toBe("Restricted");
      });
      it("is forbidden if forbidden asset is equipped", function() {
        var character;
        character = new Character({
          id: 1
        });
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          equipped: true,
          legality: 'Forbidden'
        }));
        return expect(character.legalStatus()).toBe("Forbidden");
      });
      it("is forbidden if borth resticted and forbidden equipped", function() {
        var character;
        character = new Character({
          id: 1
        });
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          equipped: true,
          legality: 'Restricted'
        }));
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          equipped: true,
          legality: 'Forbidden'
        }));
        return expect(character.legalStatus()).toBe("Forbidden");
      });
      return it("is public if forbidden assets are not equipped", function() {
        var character;
        character = new Character({
          id: 1
        });
        GameAsset.collection.add(new GameAsset({
          character_id: character.id,
          equipped: false,
          legality: 'Forbidden'
        }));
        return expect(character.legalStatus()).toBe("Public");
      });
    });
  });

}).call(this);
