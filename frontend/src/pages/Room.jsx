import { useState } from "react";
import { MdAdd } from "react-icons/md";
import NewModal from "../components/NewModal";
import Swal from "sweetalert2";
import axios from "axios";
import config from "../config";

const Room = () => {
  const [modalNew, setModalNew] = useState(false);

  const handleSave = async (data) => {
    try {
      const payload = {
        name: data.name,
        price: data.price,
      };

      const res = await axios.post(config.apiPath + "/room/create", payload);
      
      if(res.data.message == "success"){
              Swal.fire({
        title: "Save",
        text: "Save Success",
        icon: "success",
        timer:1000,
      });
      fetchData()
      setModalNew(false)
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

  const fetchData = async()=>{
    
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
      </div>
    </>
  );
};

export default Room;
