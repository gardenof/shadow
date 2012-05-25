describe "GameExpense", ->
  describe "total", ->
    it "is price", ->
      expense = new GameExpense price: 2
      expect(expense.total()).toBe 2

    it "is price/12 if pay cycle is annual", ->
      expense = new GameExpense price: 36, pay_cycle: true
      expect(expense.total()).toBe 3

  describe "annualTotal", ->
    it "is total * 12", ->
      expense = new GameExpense price: 3
      expect(expense.annualTotal()).toBe 36
