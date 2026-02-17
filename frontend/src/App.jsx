import {BrowserRouter,Routes,Route} from "react-router-dom"

import SignIn from "./pages/SignIn"
import Home from "./pages/Home"
import MainLayout from "./layouts/MainLayout"
const App = () => {
  return (
    <>
    <BrowserRouter>
    <MainLayout>

    <Routes>
      <Route path="/" element={<SignIn />} />
      <Route path="/home" element={<Home />} />

    </Routes>

    </MainLayout>
    </BrowserRouter>
    </>
  )
}

export default App