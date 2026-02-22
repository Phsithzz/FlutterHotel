import { useState } from "react";
import { useEffect } from "react";

import NewModal from "../components/NewModal";

import Swal from "sweetalert2";
import axios from "axios";
import config from "../config";

import { MdAdd } from "react-icons/md";
import { FaPencilAlt } from "react-icons/fa";
import { MdDelete } from "react-icons/md";

const Room = () => {
  const [modalNew, setModalNew] = useState(false);

  const [rooms, setRooms] = useState([]);

  const handleSave = async (data) => {
    try {
      const payload = {
        name: data.name,
        price: data.price,
      };

      const res = await axios.post(config.apiPath + "/room/create", payload);

      if (res.data.message == "success") {
        Swal.fire({
          title: "Save",
          text: "Save Success",
          icon: "success",
          timer: 1000,
        });
        fetchData();
        setModalNew(false);
      }
    } catch (err) {
      console.log(err);
      Swal.fire({
        title: "error",
        text: err.message,
        icon: "error",
      });
    }
  };

  const fetchData = async () => {
    try {
      const res = await axios.get(config.apiPath + "/room/list");

      if (res.data.results !== undefined) {
        setRooms(res.data.results);
      }
    } catch (err) {
      console.log(err);
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
      });
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const handleDelete = async(room)=>{
    try {
      const button = await Swal.fire({
        title:"Delete Room ?",
        text:"Are you Sure?",
        icon:"question",
        showCancelButton:true,
        showConfirmButton:true,
      })

      if(button.isConfirmed){
        const res = await axios.delete(config.apiPath + "/room/remove" + room.id)

        if(res.data.message == "success"){
          fetchData()
        }
      }
    } catch (err) {
      console.log(err)
      Swal.fire({
        title:"Errpr",
        text:err.message,
        icon:"error"
      })
      
    }
  }

  return (
    <>
      <div className="flex flex-col space-y-4">
        <h1 className="text-2xl font-semibold">ห้องพัก</h1>

        <button
          onClick={() => setModalNew(true)}
          type="button"
          className="cursor-pointer 
            flex items-center gap-2 text-white px-4 py-2 bg-blue-500 w-fit rounded-md font-semibold"
        >
          <MdAdd size={30} />
          New Record
        </button>
        {modalNew && (
          <>
            <div
              onClick={() => setModalNew(false)}
              className="fixed inset-0 z-50 bg-black/50 flex justify-center items-center w-full h-full"
            >
              <div
                onClick={(e) => e.stopPropagation()}
                className="bg-white rounded-md p-6 w-full shadow-2xl max-w-2xl"
              >
                <NewModal
                  onClose={() => setModalNew(false)}
                  onSave={handleSave}
                />
              </div>
            </div>
          </>
        )}

        <div className="bg-white shadow-md border rounded-lg overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="">
              <tr>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700">
                  ลำดับ
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700">
                  ชื่อห้อง
                </th>
                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-700">
                  ราคา / วัน
                </th>
                <th className="px-6 py-3 text-center text-sm font-semibold text-gray-700">
                  จัดการ
                </th>
              </tr>
            </thead>

            <tbody className="bg-white divide-y divide-gray-200">
              {rooms.length > 0 ? (
                rooms.map((room, index) => (
                  <tr key={room.id} className="hover:bg-gray-50 transition">
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {index + 1}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {room.name}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {room.price} บาท
                    </td>
                    <td className="flex gap-2 justify-center px-6 py-4 text-sm text-gray-700">
                      <button className="bg-blue-500 px-2 py-2 rounded-md">
                        <FaPencilAlt size={20}  color="white"/>
                      </button>
                      <button 
                      onClick={()=>handleDelete(room)}
                      className="bg-red-500 px-2 py-2 rounded-md">
                        <MdDelete size={20} color="white"/>
                      </button>
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
      </div>
    </>
  );
};

export default Room;
