-- CreateTable
CREATE TABLE "RoomRent" (
    "id" SERIAL NOT NULL,
    "customerName" TEXT NOT NULL,
    "customerPhone" TEXT NOT NULL,
    "rentDate" TIMESTAMP(3) NOT NULL,
    "checkinDate" TIMESTAMP(3),
    "checkoutDate" TIMESTAMP(3),
    "find" INTEGER,
    "remark" TEXT,

    CONSTRAINT "RoomRent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RoomRentDetail" (
    "id" SERIAL NOT NULL,
    "roomId" INTEGER NOT NULL,
    "roomRentId" INTEGER NOT NULL,

    CONSTRAINT "RoomRentDetail_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "RoomRentDetail" ADD CONSTRAINT "RoomRentDetail_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RoomRentDetail" ADD CONSTRAINT "RoomRentDetail_roomRentId_fkey" FOREIGN KEY ("roomRentId") REFERENCES "RoomRent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
