module.exports = {
  content: [
    "./app/views/**/*.html.slim",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        custom: {
          black: "#444",
        },
      },
    },
  },
};
