import express from "express"
import * as roomRentController from "../controllers/roomRentController.js"

const router = express.Router()

router.get("/roomRent/list",roomRentController.getRentAll)
router.post("/roomRent/isRent",roomRentController.isRent)
router.post("/roomRent/rent",roomRentController.rentRoom)

export default router