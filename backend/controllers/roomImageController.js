import { PrismaClient } from "@prisma/client";
import fs from "fs";

const prisma = new PrismaClient();

export const createImage = async (req, res) => {
  try {
    const fileRoom = req.files.fileRoom;
    fileRoom.mv("./uploads/" + fileRoom.name, async (err) => {
      if (err) throw err;

      await prisma.roomImage.create({
        data: {
          roomId: parseInt(req.params.roomId),
          name: fileRoom.name,
        },
      });

      return res.json({ message: "success" });
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ error: err.message });
  }
};

export const getAllImage = async (req, res) => {
  try {
    const roomId = parseInt(req.params.roomId);
    const results = await prisma.roomImage.findMany({
      where: {
        roomId: roomId,
      },
    });

    return res.json({
      results: results,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      error: err.message,
    });
  }
};

export const removeImageRoom = async (req, res) => {
  try {
    const id = parseInt(req.params.id);
    const row = await prisma.roomImage.findFirst({
      where: {
        id: id,
      },
    });
    if (!row) {
      return res.status(404).json({
        message: "Image not found",
      });
    }
    const imageName = row.name;
    try {
      await fs.unlink("./uploads/" + imageName);
    } catch (err) {
      console.log("File not found on disk:", err.message);
    }

    await prisma.roomImage.delete({
      where: {
        id: id,
      },
    });
    return res.json({
      message: "success",
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      error: err.message,
    });
  }
};
