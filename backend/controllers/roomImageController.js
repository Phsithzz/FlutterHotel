import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

export const createImage = async(req,res)=>{
    try {
        const fileRoom = req.files.fileRoom
        fileRoom.mv("./uploads/"+fileRoom.name,async(err)=>{
            if(err) throw err

            await prisma.roomImage.create({
                data:{
                    roomId:parseInt(req.params.roomId),
                    name:fileRoom.name,
                }
            })

            return res.json({message:"success"})
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({error:err.message})
        
    }
}

export const getAllImage = async(req,res)=>{
    try {
        const roomId = parseInt(req.params.roomId)
        const results = await prisma.roomImage.findMany({
            where:{
                roomId:roomId
            }
        })

        return res.json({
            results:results
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            error:err.message
        })
        
    }
}