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
      keyframes: {
        scrollable: {
          '0%, 100%': { position: 'relative', top: '0' },
          '50%': { position: 'relative', top: '-1rem' },
        }
      },
      animation: {
        scrollable: 'scrollable 500ms ease-in-out 3s 1',
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
