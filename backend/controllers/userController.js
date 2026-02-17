import { PrismaClient } from "@prisma/client";
import jwt from "jsonwebtoken"
import dotenv from "dotenv"

const prisma = new PrismaClient()
dotenv.config()

export const signIn = async(req,res)=>{
    try {
        const row = await prisma.user.findFirst({
            select:{
                id:true,
                name:true,
                username:true,
                level:true
            },
            where:{
                username:req.body.username,
                password:req.body.password,
                status:"use"
            }
        })

        if(row!=undefined) {
            const key = process.env.SECRET_KEY
            const token = jwt.sign(row,key,{expiresIn:"1d"})

            return res.send({token:token})
        }
        else{
            return res.status(401).send("unAuthorized")
        }
        
    } catch (err) {
        console.log(err)
        return res.status(500).json({
            error:err.message
        })
        
    }
}

export const userInfo = async(req,res)=>{
    try {
        const token = req.headers.authorization.replace("Bearer","")
        const key = process.env.SECRET_KEY
        const payload = jwt.verify(token,key)

        res.send(payload)
        
    } catch (err) {
        console.log(err)
        res.status(500).json({
            error:err.message
        })
        
    }
}