Cypress.config('baseUrl', 'http://rapidkit-storybook.lndo.site');

describe('Component: Alert Status', () => {
  it('Should have a alert status component', () => {
    const componentId = 'form-form-element';
    cy.visit(`/iframe.html?id=${componentId}`);

    cy.get('label').should('exist');

    cy.get('input').should('exist');
    cy.get('input').type('Hello World');
    cy.get('input').should('have.value', 'Hello World');
  });
});
