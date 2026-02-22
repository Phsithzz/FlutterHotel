import express from "express"
import * as roomRentController from "../controllers/roomRentController.js"

const router = express.Router()

router.get("/roomRent/list",roomRentController.getRentAll)


export default router