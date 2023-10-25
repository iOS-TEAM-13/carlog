# CarLog

### 🧑‍🤝‍🧑 Team Members (구성원)
<table>
  <tbody>
    <tr>
       <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/pinocchio22">
       <img src="https://avatars.githubusercontent.com/u/61182499?v=4" width="100px;" alt="최진훈"/>
       <br />
         <sub>
           <b>최진훈</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
    </td>
     <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/Luna828">
       <img src="https://avatars.githubusercontent.com/u/93186591?v=4" width="100px;" alt="김은경"/>
       <br />
         <sub>
           <b>김은경</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/luttoli">
       <img src="https://avatars.githubusercontent.com/u/107012166?v=4" width="100px;" alt="김지훈"/>
       <br />
         <sub>
           <b>김지훈</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
    </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/gunnieee">
       <img src="https://avatars.githubusercontent.com/u/139126902?v=4" width="100px;" alt="이동건"/>
       <br />
         <sub>
           <b>이동건</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
    </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/user2rum">
       <img src="https://avatars.githubusercontent.com/u/139091211?v=4" width="100px;" alt="조재민"/>
       <br />
         <sub>
           <b>조재민</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
    </td>
      </tbody>
  </table>
</div>

### 🍎 Final Project - “카로그”

> 스파르타코딩 iOS_7기 iOS 최종 프로젝트 `언더독` 입니다

최종 프로젝트로 결정한 APP은 `내 차 관리` App 입니다!

**앱 구성 : 보라색 하이라이트 → 기능 핵심**
> 
> - 로그인/회원가입 → `Firebase` 사용
> - MyCarPage (MainPage) 내 차 점검 목록
> - HistoryPage (주행기록 저장 / 주유 내역 저장)
> - CommunityPage (기본적인 CRUD)
> - MapPage (주유소 보여주기)
> - MyPage
> 
> 기획기간: 2023/10/10 화요일 ~ 2023/10/13 금요일
> 
> 개발기간: 2023/09/25 월요일 ~ 2023/11/15 목요일
>
> MVP(중간발표): 2023/10/30 월요일
> 
> 발표: 2023/11/17 금요일
> 

### 👊 기획의도

- 지훈님이 차 관리를 수기로 작성하는 주행일지를 보고 아이디어를 얻음
- 연비 계산을 하기 위한 주유일지가 있으면 좋겠다!
- 차량관리까지 직접 해보자

위의 3가지의 아이디어를 가지고 "내 차 관리" App을 구상하게 되었습니다. 



### 👨‍💻 역할분담 및 프로젝트 주요기능

**팀 공통**

- 프로젝트 기획
- S.A 작성 [TEAM Notion](https://spot-catcher-1ac.notion.site/TEAM13_Underdog-a7ef66f63bba4178ba2004866bf8c641?pvs=4)
- 기능구현 및 역할분담 나누기
- 와이어 프레임 [Figma](https://www.figma.com/file/gq9vtYUeLoWkuYZRnqUbrb/Underdog?type=design&node-id=0%3A1&mode=design&t=Ax4f08eMbMFsxK4c-1)
- DB 설계 및 구성 

**최진훈**

- MyCarPage UI 구현
- Model 변수명 및 재구현

**김은경**

<table>
  <tr>
    <td>
      - Login & Join Page UI 구현 <br/>
      - Firebase Auth (회원가입, 로그인, 로그인 유지, 로그아웃, 회원탈퇴 서비스 구현) 기능 <br/>
      - SMTP : 이메일 인증 구현 <br/>
      - 회원가입시, 필요한 에러처리 기능 구현 <br/>
    </td>
    <td>
      이미지 넣기
      <img src="" />
    </td>
  </tr>
</table>


**김지훈**

- HistoryPage UI 구현
- Firebase FireStore 연결 Service 구현

**이동건**

- MyPage UI 구현
- FireStore에서 Car 정보 가져오기
- LoginService 파일에 구현해둔 메서드 사용해서 로그아웃 회원탈퇴 기능 처리 구현
- 문의 전화 버튼 구현

**조재민**

- MapPage UI 구현
- 주유소

### ⚙️ Tech Stack

- iOS 15 버전으로 개발
- 스토리보드 없이
- SnapKit
- Firebase Auth
- Firebase FireStore
- URLsession
- MapKit
- UserDefaults

### WHY?

### 📚 Library

```swift
// 외부 라이브러리
* SnapKit
* Firebase
* Firebase Auth
* Firebase FireStore

// 내부 라이브러리
* MapKit
* URLSession
* UserDefaults
```

### 🔥 Project Issue

[🚨MyCarPage에서 tableview의 contentView 문제🚨](https://github.com/underdog-FinalProject/carlog/issues/16)

[🚨MyCarPage에서 collectionView 갱신 문제🚨](https://github.com/underdog-FinalProject/carlog/issues/6)

[🚨실기기에서 앱 실행 후 발생한 다크모드 ISSUE🚨](https://github.com/underdog-FinalProject/carlog/issues/39)

### 🍰 추후 목표

- 
