const mongoose = require('mongoose')
const customerSchema = new mongoose.Schema({
    username:{
        type:String
    },
    password:{
        type:String
    },
    recently_visited_locations:{
        type:[{
            Latitude:Number,
            Longitude:Number
        }]
    },
    recent_search_categories:{
        type:[String]
    },
    recent_electronic_brands:{
        type:[String]
    },
    recent_food_brands:{
        type:[String]
    },
    recent_grocery_brands:{
        type:[String]
    },
    recent_general_retail_brands:{
        type:[String]
    },
    commonly_used_payment_methods:{
        type:[{
            invoice_id:String,
            payment_method:String,
            bank_name:String,
            bank_id:String
        }]
    }
})

module.exports = mongoose.model('customer',customerSchema)
