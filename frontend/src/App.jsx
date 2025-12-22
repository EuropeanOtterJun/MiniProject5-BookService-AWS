import { Routes, Route } from "react-router-dom";
import Layout from "./layout/Layout";

import MainPage from "./pages/MainPage/MainPage.jsx";
import LoginPage from "./pages/LoginPage/LoginPage.jsx";
import SignupPage from "./pages/SignupPage/SignupPage.jsx";

import BookCreatePage from "./pages/BookCreatePage/BookCreatePage.jsx";
import BookDetailPage from "./pages/BookDetailPage/BookDetailPage.jsx";
import BookEditPage from "./pages/BookEditPage/BookEditPage.jsx";

import MyPage from "./pages/MyPage/MyPage.jsx";

import "./App.css";

// 버전 정보 상수 추가 ⭐
const APP_VERSION = "1.0.0-blue";

function App() {
  return (
    <>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<MainPage />} />

          <Route path="login" element={<LoginPage />} />
          <Route path="signup" element={<SignupPage />} />

          <Route path="books/new" element={<BookCreatePage />} />
          <Route path="books/:id" element={<BookDetailPage />} />
          <Route path="books/edit/:id" element={<BookEditPage />} />

          <Route path="mypage" element={<MyPage />} />
        </Route>
      </Routes>

      {/* 버전 표시 추가 ⭐ */}
      <div
        style={{
          position: "fixed",
          bottom: "10px",
          right: "10px",
          padding: "5px 10px",
          backgroundColor: "rgba(0, 0, 0, 0.7)",
          color: "white",
          borderRadius: "5px",
          fontSize: "12px",
          fontFamily: "monospace",
          zIndex: 9999,
        }}
      >
        v{APP_VERSION}
      </div>
    </>
  );
}

export default App;