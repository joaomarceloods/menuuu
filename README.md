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

## Benchmarking

Using the `derailed_benchmarks` gem. There are many [handful tools](https://github.com/zombocom/derailed_benchmarks).
This one measures iterations per second for a given path:

```
bundle exec derailed exec perf:ips
PATH_TO_HIT=/menu/1 bundle exec derailed exec perf:ips
PATH_TO_HIT=/menu/1 USE_SERVER=puma bundle exec derailed exec perf:ips
```

It uses the production environment, so before benchmarking, stop any running Rails server, set `force_ssl=false` and set the production database to point to the development database.

Using Apach Benchmark:

```
ab -n 1000 -c 10 http://127.0.0.1:3000/
```
