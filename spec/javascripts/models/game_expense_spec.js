(function() {

  describe("GameExpense", function() {
    return describe("total", function() {
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
  });

}).call(this);
