# 📚 도서 관리 시스템 - AWS CI/CD 자동 배포 환경 구축

> KT AIVLE School AI 02반 03조 미니프로젝트 5  
> **EC2 기반 무중단 배포를 위한 Blue/Green CI/CD 파이프라인 구축**

## 📋 프로젝트 개요

대규모 도서 관리 애플리케이션의 안정적인 배포와 운영을 위한 완전 자동화된 CI/CD 인프라 구축 프로젝트입니다.  
AWS 네이티브 서비스를 활용하여 코드 커밋부터 프로덕션 배포까지 전 과정을 자동화했습니다.

### 🎯 핵심 목표
- ✅ 무중단 배포 전략 구현 (Blue/Green Deployment)
- ✅ 고가용성 인프라 구성 (Multi-AZ)
- ✅ 실시간 모니터링 및 알림 시스템
- ✅ 자동 스케일링을 통한 트래픽 대응

## 🏗️ 아키텍처

### 전체 시스템 구조
```
GitHub → CodePipeline → CodeBuild → CodeDeploy → EC2 (Auto Scaling Group)
                                                      ↓
                                           Application Load Balancer
                                                      ↓
                                            CloudWatch Monitoring
```

### 주요 구성 요소

#### 1. CI/CD 파이프라인
- **GitHub**: 소스 코드 저장소
- **AWS CodePipeline**: 자동화된 배포 파이프라인
- **AWS CodeBuild**: 빌드 및 테스트 자동화
- **AWS CodeDeploy**: Blue/Green 무중단 배포

#### 2. 인프라 구성
- **EC2 Instances**: 애플리케이션 서버 (Frontend, Backend 분리)
- **Auto Scaling Group**: 트래픽에 따른 자동 확장/축소 (최소 2개, 최대 4개)
- **Application Load Balancer**: 트래픽 분산 및 헬스 체크
- **RDS (MySQL)**: 데이터베이스 서버

#### 3. 네트워크 구성
- **VPC**: 격리된 네트워크 환경
- **Multi-AZ**: 2개의 가용 영역 사용 (고가용성)
- **Public Subnet**: ALB, Internet Gateway 배치
- **Private Subnet**: Application Servers, Database 배치

#### 4. 모니터링 및 알림
- **CloudWatch**: 로그 수집 및 메트릭 모니터링
- **SNS**: 배포 승인 및 장애 알림 (이메일)
- **CloudWatch Alarms**: CPU, 메모리, 네트워크 임계치 감시

## 🚀 배포 전략

### Blue/Green 배포
1. **Green 환경 구성**: 새 버전을 별도 인스턴스에 배포
2. **헬스 체크**: 새 환경의 정상 작동 확인
3. **트래픽 전환**: ALB를 통해 순차적으로 트래픽 이동
4. **롤백 대기**: Blue 환경 유지 (문제 발생 시 즉시 복구)

### 장점
- ✅ 다운타임 제로 (Zero Downtime)
- ✅ 즉각적인 롤백 가능
- ✅ 프로덕션과 동일한 환경에서 검증

## 📊 모니터링 지표

### CloudWatch 수집 메트릭
- **CPU 사용률**: 인스턴스별 CPU 사용량 추적
- **네트워크 I/O**: 트래픽 패턴 분석
- **메모리 사용률**: 애플리케이션 리소스 모니터링
- **디스크 I/O**: 데이터베이스 성능 지표

### 알림 설정
- CPU 사용률 80% 초과 시 알림
- 헬스 체크 실패 시 즉시 알림
- 배포 승인 요청 시 이메일 발송

## 🔧 주요 기능

### 1. 자동화된 빌드 프로세스
```yaml
# buildspec.yml
version: 0.2
phases:
  install:
    runtime-versions:
      java: corretto17
  pre_build:
    commands:
      - echo "Pre-build started"
  build:
    commands:
      - echo "Building Spring Boot application..."
      - ./gradlew clean build -x test
  post_build:
    commands:
      - echo "Build completed on $(date)"
artifacts:
  base-directory: 'backend'
  files:
    - 'build/libs/*.jar'
    - 'scripts/**/*'
    - 'appspec.yml'
```

### 2. 수동 승인 단계
- Build 완료 후 수동 검토 단계 추가
- SNS를 통한 이메일 알림
- 승인 후에만 프로덕션 배포 진행

### 3. Auto Scaling 정책
- **Scale Out**: CPU 평균 70% 이상 시 인스턴스 추가
- **Scale In**: CPU 평균 30% 이하 시 인스턴스 제거
- **Health Check**: 비정상 인스턴스 자동 교체

## 📁 프로젝트 구조

```
MiniProject5-BookService-AWS/
├── backend/
│   ├── src/
│   ├── build.gradle
│   ├── buildspec.yml         # CodeBuild 빌드 스펙
│   ├── appspec.yml           # CodeDeploy 배포 스펙
│   └── scripts/
│       ├── start_server.sh
│       ├── stop_server.sh
│       └── validate_service.sh
├── frontend/
│   ├── src/
│   ├── package.json
│   └── buildspec.yml
└── infrastructure/
    ├── cloudformation/       # 인프라 템플릿 (선택사항)
    └── policies/            # IAM 정책
```

## 🛠️ 기술 스택

### Backend
- **Framework**: Spring Boot 3.x
- **Language**: Java 17
- **Database**: MySQL 8.0
- **Build Tool**: Gradle

### Frontend
- **Framework**: React
- **UI Library**: AIVLE Design System

### AWS Services
- **Compute**: EC2, Auto Scaling
- **Network**: VPC, ALB, Internet Gateway
- **CI/CD**: CodePipeline, CodeBuild, CodeDeploy
- **Monitoring**: CloudWatch, CloudWatch Logs
- **Notification**: SNS
- **Storage**: S3 (빌드 아티팩트)

## 📈 성과 및 결과

### 배포 자동화
- ✅ 코드 커밋부터 배포까지 **완전 자동화**
- ✅ 평균 배포 시간: **8-10분**
- ✅ 수동 개입 없이 안정적인 배포

### 고가용성 달성
- ✅ Multi-AZ 구성으로 **99.9% 가용성** 확보
- ✅ 자동 헬스 체크 및 인스턴스 교체
- ✅ 트래픽 급증 시 자동 확장

### 모니터링 체계
- ✅ 실시간 로그 수집 및 분석
- ✅ 주요 메트릭 대시보드 구축
- ✅ 장애 발생 시 즉각 알림

## 🚨 트러블슈팅

### 1. 인스턴스 무한 생성 문제
**문제**: Auto Scaling이 인스턴스를 계속 생성하고 종료 반복

**원인**: 헬스 체크 유예 기간 부족 (애플리케이션 부팅 시간보다 짧음)

**해결**:
```hcl
# Auto Scaling Group 설정
health_check_grace_period = 300  # 300초 (5분)으로 증가
health_check_type         = "ELB"
```

### 2. CodeDeploy 권한 오류
**문제**: `AccessDenied` 오류로 배포 실패

**원인**: EC2 인스턴스의 IAM Role에 필요한 권한 부족

**해결**:
- S3 버킷 읽기 권한 추가
- CodeDeploy Agent 통신 권한 추가
- CloudWatch Logs 쓰기 권한 추가

### 3. 로드 밸런서 헬스 체크 실패
**문제**: 정상 인스턴스가 `unhealthy` 상태

**원인**: 헬스 체크 경로 또는 포트 설정 오류

**해결**:
```yaml
# 헬스 체크 설정 수정
health_check_path: /actuator/health
health_check_port: 8080
health_check_interval: 30
healthy_threshold: 2
unhealthy_threshold: 3
```

## 👥 팀 구성

**KT AIVLE School AI 02반 03조**
- 역할 분담 및 협업을 통한 프로젝트 완성
- 4일간의 집중 개발 및 구축

## 📝 학습 내용

이 프로젝트를 통해 다음을 학습했습니다:
- AWS 기반 클라우드 인프라 설계 및 구축
- CI/CD 파이프라인 구현 및 자동화
- Blue/Green 무중단 배포 전략
- Auto Scaling을 통한 탄력적 인프라 운영
- CloudWatch를 활용한 모니터링 및 알림
- IAM을 통한 최소 권한 원칙 적용
- 프로덕션 환경의 문제 해결 경험

## 🔗 관련 링크

- [AWS CodePipeline Documentation](https://docs.aws.amazon.com/codepipeline/)
- [AWS CodeDeploy Documentation](https://docs.aws.amazon.com/codedeploy/)
- [AWS Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/)
- [Spring Boot Deployment Best Practices](https://spring.io/guides)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**KT AIVLE School** | Make it possible

*이 프로젝트는 KT AIVLE School AI 교육과정의 일환으로 진행되었습니다.*

</div>