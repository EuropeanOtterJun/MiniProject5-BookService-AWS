import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      "/openai": {
        target: "https://api.openai.com",
        changeOrigin: true,
        secure: false,
        rewrite: (path) => path.replace(/^\/openai/, ""),
      },
    },
  },

  test: {
    environment: 'jsdom', // 브라우저처럼 동작하게 설정
    globals: true,
    setupFiles: './src/setupTests.js', // (선택) 설정 파일 위치 지정
  }
});
