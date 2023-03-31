const mongoose = require('mongoose')
const pointSchema = new mongoose.Schema({
    type: {
      type: String,
      enum: ['Point'],
      required: true
    },
    coordinates: {
      type: [Number],
      required: true
    }
  });
const merchantSchema = new mongoose.Schema({
    merchant_id:{
        type:String
    },
    merchant_name:{
        type:String
    },
    service_categories:{
        type:[String]
    },
    Offers:{
        type:[{
            Offer_id:String,
            Offer_Category:String,
            Applicable_Payment_Methods:[String],
            Applicable_Banking_Partners:[{
               Bank_ID:String,
               Offered_Payment_Method:[String],
               Usage:{
                type:Number,
                default:0
               }
            }],
            Offer_purchases:[{
                Customer_ID:String,
                purchase_method:String,
                Banking_partner:String
            }]
    }]
    },
    location:{
        type:pointSchema
    }
})

module.exports = mongoose.model('merchant',merchantSchema)