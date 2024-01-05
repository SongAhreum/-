### 공통

- common 패키지
    - EncryptUtils 클래스 : mb5를 통한 비밀번호 암호화
    - FileManagerService 파일저장 클래스
- config 패키지
    - db설정 클래스
- Controller,BO(@Service),DAO(@Repository),model 로구성
- db join하여 들고온 data → vo 를 dto처럼 사용?
- *URL, API Controller 분리(Controller, RestControlle*r)

### JSP

- template 모듈화 (jsp:include)

### 기타

- 로그인상태일때 비로그인상태일때 다르게 구성
- 로그인정보를 세션에 담아서 옮기며 활용
- db select하는 과정에서 join활용
