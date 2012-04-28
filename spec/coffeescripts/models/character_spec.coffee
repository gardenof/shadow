describe "Character", ->
  beforeEach ->
    GameAsset.collection.reset()
    GameExpense.collection.reset()

  describe "assets", ->
    it "includes assets matching id", ->
      character = new Character id: 1
      asset = new GameAsset character_id: character.id
      GameAsset.collection.add asset
      expect(character.assets()).toContain asset

    it "doesn't include asset for another character", ->
      character = new Character id: 1
      asset = new GameAsset character_id: 2
      GameAsset.collection.add asset
      expect(character.assets()).not.toContain asset

  describe "assetTotal", ->
    it "is total of character's assets", ->
      character = new Character id: 1

      GameAsset.collection.add new GameAsset
        character_id: character.id
        price: 2
        amount: 3

      GameAsset.collection.add new GameAsset
        character_id: character.id
        price: 4
        amount: 2

      expect(character.assetTotal()).toBe 14

  describe "expenses", ->
    it "includes expenses matching id", ->
      character = new Character id: 1
      expense = new GameExpense character_id: character.id
      GameExpense.collection.add expense
      expect(character.expenses()).toContain expense

    it "doesn't include expense for another character", ->
      character = new Character id: 1
      expense = new GameExpense character_id: 2
      GameExpense.collection.add expense
      expect(character.expenses()).not.toContain expense

  describe "expenseTotal", ->
    it "is total of character's expenses", ->
      character = new Character id: 1

      GameExpense.collection.add new GameExpense
        character_id: character.id
        price: 2

      GameExpense.collection.add new GameExpense
        character_id: character.id
        price: 4

      expect(character.expenseTotal()).toBe 6

  describe "legalStatus", ->
    it "is public when character has no assets", ->
      character = new Character id: 1
      expect(character.legalStatus()).toBe "Public"

    it "is restricted if restricted asset is equipped", ->
      character = new Character id: 1

      GameAsset.collection.add new GameAsset
        character_id: character.id
        equipped: true
        legality: 'Restricted'

      expect(character.legalStatus()).toBe "Restricted"

    it "is forbidden if forbidden asset is equipped", ->
      character = new Character id: 1

      GameAsset.collection.add new GameAsset
        character_id: character.id
        equipped: true
        legality: 'Forbidden'

      expect(character.legalStatus()).toBe "Forbidden"

    it "is forbidden if borth resticted and forbidden equipped", ->
      character = new Character id: 1

      GameAsset.collection.add new GameAsset
        character_id: character.id
        equipped: true
        legality: 'Restricted'

      GameAsset.collection.add new GameAsset
        character_id: character.id
        equipped: true
        legality: 'Forbidden'

      expect(character.legalStatus()).toBe "Forbidden"

    it "is public if forbidden assets are not equipped", ->
      character = new Character id: 1

      GameAsset.collection.add new GameAsset
        character_id: character.id
        equipped: false
        legality: 'Forbidden'

      expect(character.legalStatus()).toBe "Public"
