import React, { useEffect, useState } from "react";
import axios from "axios";
import Swal from "sweetalert2";
import config from "../config";
import dayjs from "dayjs";

import { FaBook } from "react-icons/fa";
import RentModal from "../components/RentModal";

const RoomRent = () => {
  const [roomRents, setRoomRents] = useState([]);
  const [roomRent, setRoomRent] = useState({});
  const [modalRent, setModalRent] = useState(false);
  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const res = await axios.get(config.apiPath + "/roomRent/list");

      if (res.data.results !== undefined) {
        setRoomRents(res.data.results);
      }
    } catch (err) {
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
      });
    }
  };

  const openModalRoomRent = (rent) => {
    setRoomRent(rent);
  };

  return (
    <>
      <div className="flex flex-col space-y-4">
        <h1 className="text-2xl font-semibold">ข้อมูลการจองห้องพัก</h1>

        <div className="bg-white shadow-md  rounded-lg overflow-hidden border border-gray-300">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="">
              <tr>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700  border border-gray-300 "></th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700 border border-gray-300">
                  ผู้จอง
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700 border border-gray-300">
                  เบอร์โทร
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700 border border-gray-300">
                  วันที่จอง
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700 border border-gray-300">
                  วันที่จะเข้าพัก
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700 border border-gray-300">
                  วันที่สิ้นสุด
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700 border border-gray-300">
                  วันที่ชำระเงิน
                </th>
              </tr>
            </thead>

            <tbody className="bg-white ">
              {roomRents.length > 0 ? (
                roomRents.map((rent) => (
                  <tr key={rent.id} className="hover:bg-gray-50 transition">
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      <button
                        onClick={() => {
                          setModalRent(true);
                          openModalRoomRent(rent);
                        }}
                        className="cursor-pointer
                      flex items-center gap-2 bg-blue-500 text-white font-semibold px-4 py-2 rounded-md
                      "
                      >
                        <FaBook size={20} />
                        ข้อมูลการจอง
                      </button>
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      {rent.customerName}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      {rent.customerPhone}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      {dayjs(rent.rentDate).format("DD/MM/YYYY HH:mm")}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      {dayjs(rent.checkinDate).format("DD/MM/YYYY ")}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      {dayjs(rent.checkoutDate).format("DD/MM/YYYY ")}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700 border border-gray-300">
                      {rent.payDate !== null ? (
                        dayjs(rent.payDate).format("DD/MM/YYYY HH:mm")
                      ) : (
                        <button className="bg-red-500 px-4 py-2 text-white font-semibold rounded-md">
                          รอการชำระเงิน
                        </button>
                      )}
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td
                    colSpan="4"
                    className="px-6 py-4 text-center text-gray-500"
                  >
                    ไม่มีข้อมูล
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
        {modalRent && (
          <div
            onClick={() => {
              setRoomRent(false);
            }}
            className="fixed inset-0 z-50 bg-black/50 flex items-center justify-center w-full h-full"
          >
            <div
              onClick={(e) => e.stopPropagation()}
              className="bg-white rounded-md p-6 w-full shadow-2xl max-w-2xl"
            >
              <RentModal
                onClose={() => setModalRent(false)}
                roomRent={roomRent}
              />
            </div>
          </div>
        )}
      </div>
    </>
  );
};

export default RoomRent;
