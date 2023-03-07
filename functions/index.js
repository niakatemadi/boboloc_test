const functions = require("firebase-functions");
const stripe = require("stripe")("sk_test_51MhL6PF3c6zQiIn48pmDQJ3rERDipNDIsXiSzV4zcFt1ma1mfb9nGgG8RcBbimyymqFdlAOiZtGJ5xFdNj9Org8I00MW1QoZBB");

exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
    try {
      let customerId;
      const customerList = await stripe.customers.list({
        email: req.body.email,
        limit: 1
      });
  
      if (customerList.data.length !== 0) {
        customerId = customerList.data[0].id;
      } else {
        const customer = await stripe.customers.create({
          email: req.body.email
        });
        customerId = customer.data.id;
      }

      const ephemeralKey = await stripe.ephemeralKeys.create(
        { customer: customerId },
        { apiVersion: "2022-11-15" }
      );
  
      const subscription = await stripe.subscriptions.create({
        customer: customerId,
        items: [
          { price: "price_1MihunF3c6zQiIn4kbwA6QU5" }
        ],
        payment_behavior: 'default_incomplete',
        payment_settings: { save_default_payment_method: 'on_subscription' },
        expand: ['latest_invoice.payment_intent']
      });
  
  res.status(200).send({
        paymentIntent: subscription.latest_invoice.payment_intent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: customerId,
        subscriptionId: subscription.id,
        success: true
      });
    } catch (error) {
      res.status(404).send({ success: false, error: error.message });
    }
  })


 