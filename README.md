# Menuuu

QR code menu for restaurants.

## Setup

```
bin/setup
bin/dev
```

## Testing

```
rspec
```

## Debugging

Using the `debug` gem. In ruby code, add a `debugger` breakpoint.

- With `rails server`, the runtime will stop and become interactive at the breakpoint.
- With `bin/dev` (Procfile), the runtime will stop and wait for a debugger connection.
  - Open a new terminal window and connect with `bundle exec rdbg --attach --nonstop`.

# Testing Stripe

This allows you to receive Stripe webhooks locally.
When requested, enter the Stripe test API Key from `credentials.yml.enc`.

```
stripe login
stripe listen --forward-to localhost:3000/stripe/webhook
```
