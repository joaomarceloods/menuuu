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
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-2rem)' },
        },
        'ad-copy': {
          '0%, 50%': { opacity: 0 },
          '55%, 95%': { opacity: 1 },
        },
        'ad-phone': {
          '0%': {
            opacity: 0,
            transform: 'scale(0.8)',
          },
          '5%, 10%': {
            opacity: 1,
            transform: 'scale(1.2)',
          },
          '15%, 45%': {
            opacity: 1,
            transform: 'scale(2.3) translateY(22%)',
          },
          '50%, 100%': {
            opacity: 0,
            transform: 'scale(1)',
          },
        },
        'ad-screen': {
          '0%, 10%': { transform: 'translateY(38%)' },
          '45%, 100%': { transform: 'translateY(-30%)' },
        }
      },
      animation: {
        scrollable: 'scrollable 500ms ease-in-out 3s 1',
        'ad-copy': 'ad-copy 10s ease-in-out 0s infinite',
        'ad-phone': 'ad-phone 10s ease-in-out 0s infinite',
        'ad-screen': 'ad-screen 10s ease-in-out 0s infinite',
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
