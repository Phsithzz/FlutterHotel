import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

export const getRentAll = async(req,res)=>{
    try {
        const results = await prisma.roomRent.findMany({
            include:{
                RoomRentDetail:{
                    include:{
                        Room:true
                    }
                }
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