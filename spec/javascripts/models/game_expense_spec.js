(function() {

  describe("GameExpense", function() {
    describe("total", function() {
      it("is price", function() {
        var expense;
        expense = new GameExpense({
          price: 2
        });
        return expect(expense.total()).toBe(2);
      });
      return it("is price/12 if pay cycle is annual", function() {
        var expense;
        expense = new GameExpense({
          price: 36,
          pay_cycle: true
        });
        return expect(expense.total()).toBe(3);
      });
    });
    return describe("annualTotal", function() {
      return it("is total * 12", function() {
        var expense;
        expense = new GameExpense({
          price: 3
        });
        return expect(expense.annualTotal()).toBe(36);
      });
    });
  });

}).call(this);
