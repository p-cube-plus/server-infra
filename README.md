# Server Infrastructure

## 개요

개발 작업 시 사용하는 명령어 정리 중

## Git Submodule 관련련 명령어

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
sudo docker compose up -d

# 프로젝트 변경 사항 반영 원할 시 다음 명령어를 대신 실행
sudo docker compose up -d --build
```

컨테이너 종료

```bash
sudo docker compose down
```

컨테이너 재시작

```bash
sudo docker compose restart
```

컨테이너 로그 확인 (-f 옵션을 통해 실시간 출력 확인)

```bash
sudo docker compose -f container_name
```