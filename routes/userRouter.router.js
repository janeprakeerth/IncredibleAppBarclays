const customerSchema = require('../model/customer.mongo')
const express = require('express')
const userRouter = express.Router()
const merchantSchema = require('../model/merchants.mongo')

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

userRouter.post('/getOffers',async (req,res)=>{
    try{
        //required
        //user coordinates latitude and longitude
        //user search category
        //user radius
        var max_latitude = 0;
        var max_longitude = 0
        var min_latitude = 0;
        var min_longitude = 0;
        const possibleMerchants = await merchantSchema.find({
            location:{
                $near:{
                    $maxDistance:1000,
                    $geometry:{
                        type:"Point",
                        coordinates:[req.body.long,req.body.lat]
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
        res.status(500).send({
            Message:'Server Error'
        })
    }
})

module.exports = userRouter