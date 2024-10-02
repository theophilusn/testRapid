const { defineConfig } = require('cypress');

module.exports = defineConfig({
  blockHosts: ['www.google-analytics.com', 'ssl.google-analytics.com'],
  e2e: {
    baseUrl: 'https://rapidkit.lndo.site/', // TODO: Replace with your Drupal site URL.
    video: false
  },
  // This is needed so we can check google recaptcha
  chromeWebSecurity: false
});
