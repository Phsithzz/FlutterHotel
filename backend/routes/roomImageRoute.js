import express from "express"
import * as roomImageController from "../controllers/roomImageController.js"

const router = express.Router()

router.post("/roomImage/create/:roomId",roomImageController.createImage)



export default router