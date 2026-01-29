# 📚 AI 기반 도서 표지 생성 서비스 (AIVLE 5차 미니프로젝트)

본 프로젝트는 KT AIVLE School 5차 미니프로젝트로 진행된 **AI 기반 도서 표지 생성 및 도서 관리 서비스**입니다.  
사용자는 도서 정보를 입력하고 AI(OpenAI DALL·E)를 통해 어울리는 책 표지를 자동으로 생성할 수 있으며, 기본적인 도서 관리(CRUD) 및 커뮤니티(좋아요) 기능을 제공합니다.

---

## 🚀 프로젝트 개요

*   **프로젝트명**: BookService (Mini Project 5)
*   **주요 기능**: AI 도서 표지 생성, 도서 등록/수정/삭제, 카테고리별 조회, 좋아요 기능, JWT 회원 인증
*   **개발 기간**: 2024.01 (추정)
*   **팀 구성**: 2반 3조

---

## ✨ 주요 기능

### 1. 🎨 AI 도서 표지 생성
*   OpenAI **DALL·E 3 / DALL·E 2** 모델 연동
*   책 제목과 스타일에 맞춰 프롬프트를 자동 생성하여 고품질 표지 이미지를 제작
*   다양한 화풍 선택 가능 (미니멀, 일러스트, 모던, 수채화, 레트로 등)

### 2. 📚 도서 관리 (CRUD)
*   **도서 등록**: 제목, 내용, 카테고리, AI 생성 표지 등록
*   **도서 조회**: 전체 목록, 카테고리별 필터링, 최신순/인기순 정렬
*   **도서 상세**: 상세 정보 확인 및 수정/삭제 (본인 작성글만 가능)

### 3. 🔐 사용자 인증 (Auth)
*   **JWT(JSON Web Token)** 기반의 회원가입 및 로그인
*   Security를 활용한 비밀번호 암호화 (BCrypt)
*   인증된 사용자만 글 작성 및 관리 가능

### 4. ❤️ 커뮤니티 기능 & 기타
*   **좋아요 기능**: 마음에 드는 도서에 좋아요 표시 및 인기 도서(Top 10) 랭킹 반영
*   **마이페이지**: 내가 등록한 도서 목록 모아보기

---

## 🛠 기술 스택 (Tech Stack)

| 구분 | 기술 스택 |
| :--- | :--- |
| **Frontend** | ![React](https://img.shields.io/badge/React-20232A?style=flat&logo=react&logoColor=61DAFB) ![Vite](https://img.shields.io/badge/Vite-646CFF?style=flat&logo=vite&logoColor=white) ![MUI](https://img.shields.io/badge/MUI-007FFF?style=flat&logo=mui&logoColor=white) ![Axios](https://img.shields.io/badge/Axios-5A29E4?style=flat&logo=axios&logoColor=white) |
| **Backend** | ![Java](https://img.shields.io/badge/Java_17-ED8B00?style=flat&logo=openjdk&logoColor=white) ![Spring Boot](https://img.shields.io/badge/Spring_Boot_3-6DB33F?style=flat&logo=springboot&logoColor=white) ![JPA](https://img.shields.io/badge/Spring_Data_JPA-6DB33F?style=flat&logo=spring&logoColor=white) |
| **Database** | ![H2](https://img.shields.io/badge/H2_(Dev)-003B57?style=flat&logo=h2&logoColor=white) ![MySQL](https://img.shields.io/badge/MySQL_(Prod)-4479A1?style=flat&logo=mysql&logoColor=white) |
| **Infra & Tools** | ![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white) ![EC2](https://img.shields.io/badge/EC2-FF9900?style=flat&logo=amazon-ec2&logoColor=white) ![CodePipeline](https://img.shields.io/badge/CodePipeline-527FFF?style=flat&logo=amazon-aws&logoColor=white) ![Gradle](https://img.shields.io/badge/Gradle-02303A?style=flat&logo=gradle&logoColor=white) ![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white) |
| **AI** | ![OpenAI](https://img.shields.io/badge/OpenAI_DALL·E-412991?style=flat&logo=openai&logoColor=white) |

---

## 🏗 시스템 아키텍처 (Architecture)

본 서비스는 **AWS Cloud** 환경에 배포되어 운영됩니다.  
프론트엔드와 백엔드는 각각 **CI/CD 파이프라인**을 통해 자동 배포되며, 사용자는 Nginx 웹 서버를 통해 서비스를 이용하고 ALB(Application Load Balancer)를 통해 백엔드 API와 통신합니다.

### ☁️ AWS Infra Architecture
*   **Frontend**: AWS EC2 (Nginx Web Server)
*   **Backend**: AWS EC2 (Spring Boot Application)
*   **Load Balancer**: AWS Application Load Balancer (Backend API Routing)
*   **CI/CD**: AWS CodePipeline (Source: GitHub -> Build: CodeBuild -> Deploy: CodeDeploy)

![Architecture Diagram](https://github.com/user-attachments/assets/d39dcfa3-e42b-4df0-ac10-1318c030c785)

### 🚀 CI/CD Pipeline
GitHub Main 브랜치에 코드가 푸시되면 AWS CodePipeline이 동작하여 자동 배포가 수행됩니다.

1.  **Source**: GitHub Repository의 변경사항 감지
2.  **Build (CodeBuild)**:
    *   **Frontend**: Node.js 환경에서 `npm run build` 실행 (Vite 빌드)
    *   **Backend**: Gradle을 사용하여 `bootJar` 빌드
3.  **Deploy (CodeDeploy)**:
    *   **Frontend**: 빌드된 정적 파일(`dist/`)을 EC2의 Nginx 경로(`/var/www/html`)로 배포
    *   **Backend**: 빌드된 JAR 파일을 EC2로 전송하고 실행 스크립트(`start_application.sh`)를 통해 서버 재기동

---

## 📂 프로젝트 구조

```
MiniProject5
├── backend/          # Spring Boot Server
│   ├── buildspec.yml # AWS CodeBuild 명세서
│   ├── appspec.yml   # AWS CodeDeploy 명세서
│   └── src/          # Source Code
│
└── frontend/         # React Client
    ├── buildspec.yml # AWS CodeBuild 명세서 (API URL 주입 등)
    ├── appspec.yml   # AWS CodeDeploy 명세서
    ├── nginx.conf    # Nginx Web Server 설정
    └── src/          # Source Code
```

---

## 💨 시작하기 (Getting Started)

이 프로젝트는 **Frontend**와 **Backend**를 각각 실행해야 합니다.

### 1. Backend 실행
Java 17 이상이 필요합니다.

```bash
cd backend
./gradlew clean build
./gradlew bootRun
```
*   서버 주소: `http://localhost:8080`
*   H2 Console: `http://localhost:8080/h2-console`

### 2. Frontend 실행
Node.js 18 이상이 필요합니다.

```bash
cd frontend
npm install
npm run dev
```
*   접속 주소: `http://localhost:5173`

---

## 👥 팀원 소개 (2반 3조)

| 역할 | 이름 | 담당 업무 |
| :--- | :--- | :--- |
| **Backend** | **김찬우** | 회원가입/로그인, JWT, 도서 CRUD, 예외 처리 설계 |
| **Backend** | **박준성** | 도서 좋아요 기능, 프로젝트 전반 리딩 |
| **Backend** | **안지운** | 인기/카테고리 목록 API 구현 |
| **Backend** | **이동욱** | 마이페이지, 유저 도서 목록 조회 구현 |
| **Frontend** | **All** | 프론트엔드 UI/UX 및 기능 연동 공동 작업 |

---

## 📝 라이선스 및 참고
이 프로젝트는 교육용으로 제작되었으며, KT AIVLE School의 자산입니다.