import { Outlet } from "react-router-dom"
import Navbar from "../components/Navbar"
import Sidebar from "../components/SideBar"

export default function MainLayout() {
  return (
    <div className="flex h-screen bg-gray-100">
      
 
      <Sidebar />


      <div className="flex flex-col flex-1">
        

        <Navbar />

        <main className="flex-1 p-6 overflow-auto">
          <Outlet/>
        </main>

      </div>
    </div>
  )
}
