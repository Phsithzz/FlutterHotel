import express from "express"
import * as roomController from "../controllers/roomController.js"

const router = express.Router()

router.post("/room/create",roomController.createRoom)
router.get("/room/list",roomController.getAllRoom)

export default router