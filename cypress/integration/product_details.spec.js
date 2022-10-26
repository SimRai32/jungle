it("There is products on the page", () => {
  cy.visit('/');
  cy.get(".products article").should("be.visible");
});
it("Can get to product article", () => {
  cy.get(".products article").contains('Giant').click();
  cy.get(".product-detail div p").contains("The Giant Tea is an uncommon");
});
