const mongoose = require('mongoose')
const bankingPartners = new mongoose.Schema({
    bank_id:String,
    services_offered:[String],
    card_offers_count:Number,
    emi_offers_count:Number,
    average_service_rating:Number,
    img_url:String
})

module.exports = mongoose.model('banks',bankingPartners)