const customerSchema = require('../model/customer.mongo')
const express = require('express')
const userRouter = express.Router()
const merchantSchema = require('../model/merchants.mongo')
function kmToRadians(distance) {
    const earthRadiusInKm = 6371; // Earth's radius in kilometers
    const radiansPerDegree = Math.PI / 180;
    return distance / earthRadiusInKm * radiansPerDegree;
  }
userRouter.post('/login',async (req,res)=>{
    try{
        const customer = customerSchema.findOne({
            username:req.body.username,
            password:req.body.password
        })
        if(customer){
            res.status(200).send({
                Message:'Success'
            })
        }
        else{
            res.status(200).send({
                Message:'Invalid Credentials'
            })
        }
    }catch(e){
        res.status(500).send({
            Message:'Server Error'
        })
    }
})
userRouter.post('/signup',async (req,res)=>{
    try{
        const customer = customerSchema.findOne({
            username:req.body.username
        })
        if(customer){
            res.status(200).send({
                Message:'Already Registered'
            })
        }
        else{
            const cust = new customerSchema({
                username:req.body.username,
                password:req.body.password
            })
            const r = await cust.save()
            if(r){                
                res.status(200).send({
                    Message:'Registered Successfully'
                })
            }
            else{
                res.status(200).send({
                    Message:'Error'
                })
            }
        }
    }catch(e){
        res.status(500).send({
            Message:'Server Error'
        })
    }
})

userRouter.get('/getOffers',async (req,res)=>{
    try{
        //required
        //user coordinates latitude and longitude
        //user search category
        //user radius
        const radian_distance = kmToRadians(req.query.distinKm) 
        const possibleMerchants = await merchantSchema.find({
            location:{
                $near:{
                    $maxDistance:radian_distance,
                    $geometry:{
                        type:"Point",
                        coordinates:[req.query.long,req.query.lat]
                    }
                }
            }
        })

        if(possibleMerchants){
            res.status(200).send({
                Message:'Success',
                merchants:possibleMerchants
            })
        }
        else{
            res.status(200).send({
                Message:'No locations found'
            })
        }
    }catch(e){
        console.log(e)
        res.status(500).send({
            Message:'Server Error'
        })
    }
})

userRouter.get('/createTestMerchant',async (req,res)=>{
    try{
        const tm = new merchantSchema({
            merchant_id:1,
            merchant_name:'test_merchant',
            location: {
                type: "Point",
                coordinates: [-112.110492,36.098948]
            }
        })
        const t = await tm.save()
        if(t){
            res.status(200).send({
                Message:'Saved'
            })
        }
    }catch(e){
        console.log(e)
    }
})

userRouter.post('/getRecentDeals',async (req,res)=>{
    //
    try{
        const customer = await customerSchema.findOne({
            username:req.body.username
        })
        if(customer){
            const recent_searches = customer.recent_search_categories;
            //last search
            const last_search_topic = recent_searches[recent_searches.length-1]
            //get offers in nearby location
            //get latitude, longitude, use category filter
            const possibleMerchants = await merchantSchema.find({
                location:{
                    $near:{
                        $maxDistance:radian_distance,
                        $geometry:{
                            type:"Point",
                            coordinates:[req.body.long,req.body.lat]
                        }
                    }
                },
                service_categories:{
                    last_search_topic
                }
            })
            if(possibleMerchants){
                res.status(200).send({
                    Message:'Success',
                    possiblemerchants:possibleMerchants
                })
            }
            else{
                res.status(200).send({
                    Message:'Failure'
                })
            }
        }
        else{
            res.status(200).send({
                Message:'User not found'
            })
        }
    }catch(e){
        console.log(e)
        res.status(500).send({
            Message:'Error'
        })
    }
})

userRouter.post('/getOffersBasedOnFrequency',async (req,res)=>{
    try{
        const customer = await customerSchema.findOne({
            username:req.body.username
        })
        if(customer){
            const recent_searches = customer.recent_search_categories;
            const occurrences = recent_searches.reduce(function (acc, curr) {
                return acc[curr] ? ++acc[curr] : acc[curr] = 1, acc
              }, {});
            let sortable=[];
            for(i in occurrences){
                sortable.push([i,occurrences[i]])
            }
            sortable.sort(function(a,b){
                a[1]-b[1]
            })
            const most_frequent_category = sortable[sortable.length-1][0]
            //now find offers
            const reqd_merchants = await merchantSchema.find({
                Offers:{
                    $elemMatch:{
                        Offer_category:most_frequent_category
                    }
                }
            })

            if(reqd_merchants){
                res.status(200).send({
                    Message:'Success',
                    merchants:reqd_merchants
                })
            }
            else{
                res.status(200).send({
                    Message:'Failure'
                })
            }
        }
    }catch(e){
        res.status(500).send({
            Message:'Failure' 
        })
    }
})

module.exports = userRouter