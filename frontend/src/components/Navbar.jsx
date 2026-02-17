
const Navbar = () => {
  return (
    <div className="h-16 bg-white shadow flex items-center justify-between px-6">
      
      <a href = "/home" className="font-semibold text-lg">Home</a>

      <div className="flex items-center gap-4">
        <button className="hover:text-gray-600">🔍</button>
        <button className="hover:text-gray-600">🔔</button>
        <button className="hover:text-gray-600">⚙️</button>
      </div>

    </div>
  )
}

export default Navbar