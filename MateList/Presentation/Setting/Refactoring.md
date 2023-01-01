#  Info
## 기능 
내 정보 및 로그인 화면

## View
--- UIView (배경)
  |---- UIView (내 정보 Container)
  |------- UILabel (이름)
  |------- UILabel (이메일)
  |------- UILabel (내 이름)
  |------- UILabel (내 이메일)
  |---- UIButton (생활 패턴 보기)
  |---- UIButton (문의하기)
  |---- UIButton (로그아웃)
  |---- UIButton (회원탈퇴)
  |---- UILabel (소셜로그인)
  |---- UIStackView 
  |------- UIButton (애플 로그인)
  |------- UIButton (구글 로그인)
  
## Function
- 구글 로그인
    - 구글 로그인 후 Auth로 넘겨주기 () -> AuthCredential
    - 공통 auth 로그인 (credential: AuthCredential)
    - 파이어베이스 등록 (user: User)
- 애플 로그인
    - apple 함수를 통해 credential auth로 넘겨주기 -> AuthCredential
    - 공통 auth 로그인 (credential: AuthCredential)
    - 파이어 베이스 등록 (user: User)
- 로그아웃 
- 회원 탈퇴
    - 스크랩 삭제
    - 생활 패턴 삭제
    - 유저가 작성한 글 삭제
    - 유저 삭제
    - App Delegate 로그아웃
- 팝업 
    - 회원 탈퇴 시
    - 블랙 리스트일 경우
- 문의하기 
    - 메일 뷰 띄우기
    - 파일 에러 메세지
- 데이터 베이스 체크 
    - 유저 존재하는지 체크
    - 블랙리스트 체크
    - 닉네임 가져오기 
- 파이어 베이스에 등록
    - 개인 정보 제공 동의서 제출
- 로그인 버튼 활성화, 비활성화

# Consent_popup
## 기능 
게시글 이용 시 주의사항 알려주는 팝업 

## View
--- UIView (배경)
  |---- Button (동의)
  |---- Button (거절)
  |---- TextView (내용)
  |---- Label (제목)

## Function
- closePopupBtn 
- agreepopupBtn

## 메모 
- 파일,함수 컨벤션에 맞게 이름 변경

# NickNameView

