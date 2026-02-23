import { ImCross } from "react-icons/im";
const RentModal = ({onClose,roomRent}) => {
  return (
   <>
   
         <div className="flex flex-col space-y-4">


           <div className="flex justify-between items-center ">
             <h1 className="text-2xl font-semibold">ข้อมูลการจองห้องพัก</h1>
             <button
      onClick={onClose}
               className="cursor-pointer hover:text-red-500 
             transition ease-in duration-200"
             >
               <ImCross size={20} />
             </button>
           </div>

   <div className="overflow-hidden rounded-xl border border-gray-300">
          <table className="min-w-full text-sm">
            <thead className="bg-gray-100">
              <tr>
                <th className="px-6 py-3 text-left font-semibold border border-gray-300">
                  ห้อง
                </th>
                <th className="px-6 py-3 text-left font-semibold border border-gray-300">
                  ราคา
                </th>
              </tr>
            </thead>

            <tbody>
              {roomRent?.RoomRentDetail &&
              roomRent.RoomRentDetail.length > 0 ? (
                roomRent.RoomRentDetail.map((detail, index) => (
                  <tr
                    key={index}
                    className={`${
                      index % 2 === 0 ? "bg-white" : "bg-gray-50"
                    } hover:bg-blue-50 transition`}
                  >
                    <td className="px-6 py-4 border border-gray-300">
                      {detail.Room.name}
                    </td>
                    <td className="px-6 py-4 border border-gray-300">
                      {detail.Room.price} บาท
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td
                    colSpan="2"
                    className="px-6 py-6 text-center text-gray-500 border border-gray-300"
                  >
                    ไม่มีข้อมูล
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
   

         </div>
   </>
  )
}

export default RentModal