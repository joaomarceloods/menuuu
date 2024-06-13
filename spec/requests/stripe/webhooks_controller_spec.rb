require 'rails_helper'

RSpec.describe Stripe::WebhooksController, type: :request do
  describe "#post" do
    # Hardcoded values retrieved from a real Stripe subscription in test mode
    let(:stripe_client_reference_id) { 1 } # this is the business_id
    let(:stripe_subscription_id) { "sub_1PD96FCuBTi6G1R5PPed5zm0" }
    let(:stripe_checkout_session_id) { "cs_test_a1D0G8mQMHybRONDbHrDADZwSs0WCXbfY4yqmYgFvOvKvdMVXvi1zCATrZ" }
    let(:stripe_event_checkout_completed) { "evt_1PD96KCuBTi6G1R5YDlGXwLo" }
    let(:stripe_event_subscription_created) { "evt_1PD96ICuBTi6G1R5IFVJiTCY" }
    let(:stripe_event_subscription_updated) { "evt_1PD97ICuBTi6G1R5Pul6kvnm" }
    let(:stripe_event_subscription_deleted) { "evt_1PD98DCuBTi6G1R5DaH8Txn3" }

    let(:path) { '/stripe/webhook' }
    let(:user) { User.create!(email: "john@doe.com", password: "password123@") }

    let!(:business) {
      Business.create!(
        id: stripe_client_reference_id,
        name: "My Business",
        user:
      )
    }

    let(:subscription) {
      Subscription.create!(
        stripe_subscription_id: stripe_subscription_id,
        expired_at: 1.year.from_now
      )
    }

    describe "with event type customer.subscription.created" do
      context 'when the subscription does not exist' do
        it "creates a new subscription" do
          expect {
            post path, params: stub_stripe_event(stripe_event_subscription_created).to_h
          }.to change {
            Subscription.count
          }.by(1)
        end
      end

      context 'when the subscription exists' do
        it "does not create a new subscription" do
          subscription
          expect {
            post path, params: stub_stripe_event(stripe_event_subscription_created).to_h
          }.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end
    end

    describe "with event type customer.subscription.updated" do
      it "updates an existing subscription" do
        expect {
          post path, params: stub_stripe_event(stripe_event_subscription_updated).to_h
        }.to change {
          subscription.reload.expired_at.year
      }.by(1)
      end
    end

    describe "with event type customer.subscription.deleted" do
      context 'when the subscription exists' do
        it "deletes a subscription" do
          expect {
            post path, params: stub_stripe_event(stripe_event_subscription_deleted).to_h
          }.to change {
            Subscription.exists?(subscription.id)
          }.from(true).to(false)
        end
      end

      context 'when the subscription does not exist' do
        it "does not change anything" do
          expect {
            post path, params: stub_stripe_event(stripe_event_subscription_deleted).to_h
          }.not_to change {
            Subscription.count
          }
        end
      end
    end

    describe "with event type checkout.session.completed" do
      it "sets subscription business_id and stripe_checkout_session_id" do
        expect {
          post path, params: stub_stripe_event(stripe_event_checkout_completed).to_h
        }.to change {
          subscription.reload.values_at(:business_id, :stripe_checkout_session_id)
        }.from([nil, nil]).to([stripe_client_reference_id, stripe_checkout_session_id])
      end
    end
  end

  def stub_stripe_event(event_id)
    VCR.use_cassette(event_id) do
      Stripe::Event.retrieve(event_id).tap do |event|
        expect(Stripe::Webhook).to receive(:construct_event).and_return(event)
      end
    end
  end
end
