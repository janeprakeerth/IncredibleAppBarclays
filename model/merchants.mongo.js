const mongoose = require('mongoose')
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
        items:[{
            Offer_id:String,
            Offer_Category:String,
            Offer_description:String,
            Applicable_Payment_Methods:[String],
            Applicable_Banking_Partners:[{
               Bank_ID:String,
               Offered_Payment_Method:[String],
               Usage:{
                type:Number,
                default:0
               }
            }]
    }]
    },
            Offer_purchases:[{
                Customer_ID:String,
                purchase_method:String,
                Banking_partner:String,
                offer_id:String
            }],
    location:{
        type: {
            type: String,
          },
          coordinates: {
            type: [Number]
          }
    },
    product_catalogue:[{
        product_id:String,
        product_name:String,
        product_category:String,
        product_brand:String,
        product_model_no:String,
        offer_id:String,
        product_rating:Number,
        no_of_purchases:Number,
        reviews:[String]      
    }],
    merchant_visits:[String], //string of customer ids
    merchant_ratings:[{
        Customer_id:String,
        Rating:Number,
        Review:String  
    }],
    merchant_average_rating:{
        type:Number,
        default:0
    },
    Img_url:{
        type:String
    }
})
merchantSchema.index({ location: "2dsphere" });
module.exports = mongoose.model('merchant',merchantSchema)