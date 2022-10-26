it("There is products on the page", () => {
  cy.visit('/');
  cy.get(".products article").should("be.visible");
});
it("Can add item to cart", () => {
  cy.visit('/');
  cy.get(".products article .btn").first().click({force: true});
  cy.get(".nav-link").contains("My Cart (1)");
});