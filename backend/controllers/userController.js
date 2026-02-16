import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

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

        if(row!=undefined) return res.send("Login Success")
        return res.status(401).send("unAuthorized")
    } catch (err) {
        console.log(err)
        return res.status(500).json({
            error:err.message
        })
        
    }
}