-- CreateTable
CREATE TABLE "RoomImage" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "roomId" INTEGER NOT NULL,

    CONSTRAINT "RoomImage_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "RoomImage" ADD CONSTRAINT "RoomImage_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
