const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      borderRadius: {
        phone: '3rem',
        'phone-lg': '4.5rem',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      fontSize: {
        inherit: 'inherit',
      },
      height: {
        phone: '852px',
      },
      spacing: {
        navigation: '2.75rem',
      },
      margin: {
        '120': '30rem',
      },
      transitionProperty: {
        visibility: 'visibility',
      },
      width: {
        phone: '393px',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
