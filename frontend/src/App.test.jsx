// frontend/src/App.test.jsx
import { render, screen } from '@testing-library/react';
import App from './App';
import { describe, it, expect } from 'vitest';
import '@testing-library/jest-dom'; // 편리한 문법 사용을 위해 import

describe('App 컴포넌트 테스트', () => {
  it('메인 화면이 정상적으로 렌더링 되어야 한다', () => {
    // 1. App 컴포넌트를 가상으로 화면에 그립니다.
    render(<App />);
    
    // 2. 화면에 특정 글자가 보이는지 찾습니다.
    // 주의: 실제 App.jsx 화면에 있는 글자 중 하나를 적으세요! (예: "로그인", "환영합니다", "Team0203" 등)
    // /글자/i 라고 쓰면 대소문자 구분 없이 찾습니다.
    const linkElement = screen.getByText(/로그인/i); 
    // 만약 "로그인"이라는 글자가 없다면 다른 걸로 바꾸세요!

    // 3. 그 글자가 문서(Document)에 존재하는지 확인합니다.
    expect(linkElement).toBeInTheDocument();
  });
});