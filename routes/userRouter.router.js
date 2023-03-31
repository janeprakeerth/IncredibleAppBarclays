const customerSchema = require("../model/customer.mongo");
const express = require("express");
const userRouter = express.Router();
const merchantSchema = require("../model/merchants.mongo");
function kmToRadians(distance) {
  const earthRadiusInKm = 6371; // Earth's radius in kilometers
  const radiansPerDegree = Math.PI / 180;
  return (distance / earthRadiusInKm) * radiansPerDegree;
}
userRouter.post("/login", async (req, res) => {
  try {
    const customer = customerSchema.findOne({
      username: req.body.username,
      password: req.body.password,
    });
    if (customer) {
      res.status(200).send({
        Message: "Success",
      });
    } else {
      res.status(200).send({
        Message: "Invalid Credentials",
      });
    }
  } catch (e) {
    res.status(500).send({
      Message: "Server Error",
    });
  }
});
userRouter.post("/signup", async (req, res) => {
  try {
    const customer = customerSchema.findOne({
      username: req.body.username,
    });
    if (customer) {
      res.status(200).send({
        Message: "Already Registered",
      });
    } else {
      const cust = new customerSchema({
        username: req.body.username,
        password: req.body.password,
      });
      const r = await cust.save();
      if (r) {
        res.status(200).send({
          Message: "Registered Successfully",
        });
      } else {
        res.status(200).send({
          Message: "Error",
        });
      }
    }
  } catch (e) {
    res.status(500).send({
      Message: "Server Error",
    });
  }
});

userRouter.get("/getOffers", async (req, res) => {
  try {
    //required
    //user coordinates latitude and longitude
    //user search category
    //user radius
    const radian_distance = kmToRadians(req.query.distinKm);
    console.log(radian_distance);
    console.log(Number(req.query.long));
    const possibleMerchants = await merchantSchema.find({
      location: {
        $near: {
          $maxDistance: req.query.distinKm * 1000,
          $geometry: {
            type: "Point",
            coordinates: [Number(req.query.long), Number(req.query.lat)],
          },
        },
      },
    });
    if (possibleMerchants) {
      res.status(200).send({
        Message: "Success",
        merchants: possibleMerchants,
      });
    } else {
      res.status(200).send({
        Message: "No locations found",
      });
    }
  } catch (e) {
    console.log(e);
    res.status(500).send({
      Message: "Server Error",
    });
  }
});

userRouter.get("/createTestMerchant", async (req, res) => {
  try {
    const tm = new merchantSchema({
      merchant_id: 1,
      merchant_name: "test_merchant",
      location: {
        type: "Point",
        coordinates: [-112.110492, 36.098948],
      },
    });
    const t = await tm.save();
    if (t) {
      res.status(200).send({
        Message: "Saved",
      });
    }
  } catch (e) {
    console.log(e);
  }
});

userRouter.get("/getRecentDeals", async (req, res) => {
  //
  try {
    const radian_distance = kmToRadians(40);
    console.log(radian_distance);
    const customer = await customerSchema.findOne({
      username: req.query.username,
    });
    if (customer) {
      const recent_searches = customer.recent_search_categories;
      //last search
      const last_search_topic = recent_searches[recent_searches.length - 1];
      //get offers in nearby location
      //get latitude, longitude, use category filter
      const possibleMerchants = await merchantSchema.find({
        location: {
          $near: {
            $maxDistance: req.query.distinKm * 1000,
            $geometry: {
              type: "Point",
              coordinates: [Number(req.query.long), Number(req.query.lat)],
            },
          },
        },
        service_categories: { $all: [last_search_topic] },
      });
      if (possibleMerchants) {
        res.status(200).send({
          Message: "Success",
          possiblemerchants: possibleMerchants,
        });
      } else {
        res.status(200).send({
          Message: "Failure",
        });
      }
    } else {
      res.status(200).send({
        Message: "User not found",
      });
    }
  } catch (e) {
    console.log(e);
    res.status(500).send({
      Message: "Error",
    });
  }
});

// userRouter.post('/getOffersBasedOnFrequency',async (req,res)=>{
//     try{
//         const customer = await customerSchema.findOne({
//             username:req.body.username
//         })
//         if(customer){
//             const recent_searches = customer.recent_search_categories;
//             const occurrences = recent_searches.reduce(function (acc, curr) {
//                 return acc[curr] ? ++acc[curr] : acc[curr] = 1, acc
//               }, {});
//             let sortable=[];
//             for(i in occurrences){
//                 sortable.push([i,occurrences[i]])
//             }
//             sortable.sort(function(a,b){
//                 a[1]-b[1]
//             })
//             const most_frequent_category = sortable[sortable.length-1][0]
//             //now find offers
//             const reqd_merchants = await merchantSchema.find({
//                 Offers:{
//                     $elemMatch:{
//                         Offer_category:most_frequent_category
//                     }
//                 }
//             })

//             if(reqd_merchants){
//                 res.status(200).send({
//                     Message:'Success',
//                     merchants:reqd_merchants
//                 })
//             }
//             else{
//                 res.status(200).send({
//                     Message:'Failure'
//                 })
//             }
//         }
//     }catch(e){
//         res.status(500).send({
//             Message:'Failure'
//         })
//     }
// })

// To add new merchants
userRouter.post("/newMerchant", (req, res) => {
  const testMerchant = req.body;
  const addData = merchantSchema.create(testMerchant);
  addData ? res.status(200) : res.status(500);
  addData ? res.send("Success") : res.send("Error");
});

userRouter.get('/suggestAlternatives',async (req,res)=>{
    try{
        const r = await merchantSchema.find({
            location:{
                $near:{
                    $maxDistance:req.query.distinKm*1000,
                    $geometry:{
                        type:"Point",
                        coordinates:[Number(req.query.long),Number(req.query.lat)]
                    }
                }
            },
            service_categories:{$all:[req.query.search_category]},
            product_catalogue:{$elemMatch:{
                product_model_no:req.query.product_model_no
            }}
        })
        if(r){
            res.status(200).send({
                Message:'Success',
                merchants:r
             })
        }
        else{
            res.status(200).send({
                Message:'Failure' 
            })
        }
    }catch(e){
        res.status(500).send({
            Message:'Server Error'
        })
    }
})
