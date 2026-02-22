import express from "express"
import dotenv from "dotenv"
import cors from "cors"
import fileUpload from "express-fileupload"

import userRoute from "./routes/userRoute.js"
import roomRoute from "./routes/roomRoute.js"
import roomImageRoute from "./routes/roomImageRoute.js"
import roomRentRoute from "./routes/roomRentRoute.js"
dotenv.config()
const app = express()

app.use(express.json())
app.use(cors())
app.use(fileUpload())
app.use("/uploads",express.static("uploads"))

app.get("/",(req,res)=>{
    res.send("API Working")
})

app.use(userRoute)
app.use(roomRoute)
app.use(roomImageRoute)
app.use(roomRentRoute)


const port = process.env.PORT || 3000
app.listen(port,()=>{
    console.log(`"Server is Running on Port ${port}`)
})