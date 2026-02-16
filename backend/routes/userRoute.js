import express from "express"
import * as userController from "../controllers/userController.js"

const router = express.Router()

router.post("/admin/signin",userController.signIn)



export default router