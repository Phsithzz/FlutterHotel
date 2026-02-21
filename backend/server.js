import express from "express"
import dotenv from "dotenv"
import cors from "cors"

import userRoute from "./routes/userRoute.js"
import roomRoute from "./routes/roomRoute.js"
dotenv.config()
const app = express()

app.use(express.json())
app.use(cors())

app.get("/",(req,res)=>{
    res.send("API Working")
})
app.use(userRoute)
app.use(roomRoute)

const port = process.env.PORT || 3000
app.listen(port,()=>{
    console.log(`"Server is Running on Port ${port}`)
})