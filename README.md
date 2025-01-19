# Server Infrastructure

## 개요

작업 시 참고 사항 정리

## 환경변수 설정

각 경로의 `.env.example`의 내용을 바탕으로 `.env` 파일을 생성하세요. **절대로 저장소에 올리지 말 것.**

이후 보안을 위해 다음 명령어를 실행하세요.

```bash
chmod 600 .env
```

## config.ini 생성

`backend/config/` 경로에 `config.ini`를 생성한 뒤 내용을 작성하고 다음 명령어를 실행하세요.

```bash
chmod 600 config.ini
```

## Git Submodule 관련 명령어

submodule 업데이트 (최신 커밋으로 업데이트)

```bash
git submodule update --init
```

`.gitmodules`의 submodule url 변경 시 sync

```bash
git submodule sync
```

## Docker 관련 명령어

### docker container 실행

컨테이너 실행

```bash
docker compose up -d

# 프로젝트 변경 사항 반영 원할 시 다음 명령어를 대신 실행
docker compose up -d --build
```

컨테이너 종료

```bash
docker compose down
```

컨테이너 재시작

```bash
docker compose restart
```

컨테이너 로그 확인 (-f 옵션을 통해 실시간 출력 확인)

```bash
docker compose -f container_name
```