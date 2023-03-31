const customerSchema = require('../model/customer.mongo')
const express = require('express')
const userRouter = express.Router()

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


module.exports = userRouter