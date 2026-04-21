# Git 히스토리 비밀번호 일괄 삭제 가이드 (git-filter-repo)

이미 GitHub에 푸시된 비밀번호를 히스토리 전체에서 찾아 삭제하고, 다른 문구로 치환하는 최신 표준 방법입니다.

## ⚠️ 중요 주의사항 (실행 전 필독)

1. **커밋 ID 변경**: 이 작업을 수행하면 기존의 모든 커밋 해시(ID)가 변경됩니다.
2. **협업자 주의**: 다른 팀원이 있다면 기존 저장소를 버리고 수정된 버전을 새로 `clone` 받아야 합니다. (기존 브랜치와 충돌 발생)
3. **강제 푸시**: 원격 저장소의 기록을 덮어쓰기 위해 `force push`가 필요합니다.
4. **실제 비밀번호 변경**: Git 히스토리를 지우는 것과 별개로, 이미 노출된 비밀번호는 반드시 실제 서비스에서 변경해야 합니다.

---

## 0. 준비 작업 (설치)

Python 및 `uv`가 설치된 환경에서 아래 명령어를 실행하여 도구를 설치합니다. `uv tool`은 도구를 독립된 가상 환경에 격리하여 설치하므로 시스템 오염을 방지합니다.

```bash
# uv를 이용한 전역 도구 설치
uv tool install git-filter-repo
```

## 1. 저장소 백업 및 준비

`git-filter-repo`는 안전을 위해 '방금 clone 받은 깨끗한 상태'에서 작업하는 것을 권장합니다.

```bash
# 새로운 폴더에 저장소를 다시 clone 받습니다.
git clone https://github.com/사용자이름/저장소이름.git cleanup-temp
cd cleanup-temp
```

## 2. 치환 목록 파일 생성 (`passwords.txt`)

삭제할 비밀번호와 대체할 문구를 정의합니다. 파일명은 자유입니다.
파일 내용 형식: `찾을문자열==>바꿀문자열`

```text
kosa1004==>REMOVED_PASSWORD
123456==>REMOVED_PASSWORD
my_secret_key==>REMOVED_KEY
```

_(바꿀 문자열을 비워두면 해당 단어만 쏙 삭제됩니다.)_

## 3. 히스토리 재작성 실행

### 방법 A: 특정 단어만 찾아 치환하기 (비밀번호 등)

이 명령어는 **모든 브랜치와 모든 태그**를 뒤져서 위 파일에 적힌 문자열을 치환합니다.

```bash
git filter-repo --replace-text passwords.txt
```

### 방법 B: 특정 파일 자체를 히스토리에서 삭제하기 (.env 등)

실수로 `.env`나 `config.json` 같은 파일을 푸시했을 때, 과거의 모든 커밋에서 해당 파일을 완전히 제거합니다.

```bash
# 단일 파일 삭제
git filter-repo --path .env --invert-paths

# 여러 파일이나 폴더 삭제
git filter-repo --path .env --path config/secret.json --invert-paths
```

## 4. 재발 방지 (.gitignore 설정)

파일을 히스토리에서 지웠다면, 앞으로 다시는 추적되지 않도록 `.gitignore`에 등록해야 합니다.

1. 프로젝트 루트에 `.gitignore` 파일을 생성하거나 엽니다.
2. 제외할 파일명을 추가합니다.
   ```text
   .env
   passwords.txt
   secrets/
   ```
3. 변경사항을 커밋합니다. (이때 .env 파일은 이미 삭제된 상태여야 합니다.)

## 5. 원격 저장소 연결 복구

`git-filter-repo`를 실행하면 안전을 위해 기존 `origin` 원격 연결이 해제됩니다. 다시 연결해줍니다.

```bash
git remote add origin https://github.com/사용자이름/저장소이름.git
```

## 5. 강제 푸시 (반영)

수정된 히스토리를 서버에 강제로 덮어씁니다.

```bash
# 모든 브랜치 반영
git push origin --force --all

# 모든 태그 반영
git push origin --force --tags
```

---

## 💡 자주 묻는 질문 (FAQ)

### Q: 브랜치가 여러 개인데 각각 따로 해야 하나요?

**A: 아니요.** `git-filter-repo`는 기본적으로 전체 저장소의 모든 참조(References), 즉 모든 브랜치와 태그를 대상으로 작동합니다. 한 번의 실행으로 모든 곳에서 비밀번호가 사라집니다.

### Q: 특정 파일에서만 지우고 싶은데 어떻게 하나요?

**A: `--path` 옵션을 조합할 수 있습니다.** 하지만 비밀번호 치환(`--replace-text`)의 경우, 보통 전체 파일에서 해당 단어를 지우는 것이 가장 안전하므로 위 가이드 방식을 권장합니다.

### Q: 실행 시 "fresh clone" 에러가 납니다.

**A: `--force` 옵션을 붙여서 강제 실행할 수 있습니다.**
`git filter-repo --replace-text passwords.txt --force`
(단, 작업 중인 수정 사항이 있다면 모두 날아갈 수 있으니 주의하세요.)
