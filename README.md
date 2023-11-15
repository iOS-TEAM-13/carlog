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

**팀 전체**

✔️프로젝트 기획 <br/>
✔️S.A 작성 [TEAM Notion](https://spot-catcher-1ac.notion.site/TEAM13_Underdog-a7ef66f63bba4178ba2004866bf8c641?pvs=4) <br/>
✔️기능구현 및 역할분담 나누기 <br/>
✔️와이어 프레임 [Figma](https://www.figma.com/file/gq9vtYUeLoWkuYZRnqUbrb/Underdog?type=design&node-id=0%3A1&mode=design&t=Ax4f08eMbMFsxK4c-1) <br/>
✔️DB 설계 및 구성 

<table width="100">
   <tr>
      <td>
         ✔️MyCarPage UI 구현<br/>
         ✔️MapPage UI 및 기능구현<br/>
         ✔️Model 변수명 및 재구현<br/>
      </td>
      <td>
         ✔️Login & Join Page UI 구현 <br/>
         ✔️Firebase Auth 기능 <br/>
         ✔️SMTP 이메일 인증 구현 <br/>
         ✔️회원가입 유효성 검사 구현 <br/>
         ✔️회원가입 유효성 검사 구현 <br/>
      </td>
      <td>
         ✔️HistoryPage UI 구현<br>
         ✔️FireStore 연결 및 서비스구현<br>
      </td>
      <td>
         ✔️MyPage UI 구현 <br>
         ✔️FireStore에서 Car 정보 가져오기 <br>
         ✔️LoginService 파일에 구현해둔 메서드 사용해서 로그아웃 회원탈퇴 기능 처리 구현 <br>
         ✔️문의 전화 버튼 구현 <br>
      </td>
      <td>
         ✔️MapPage UI 구현 <br>
         ✔️주유소 <br>
      </td>
   </tr>
   <tr align="center">
      <td>
         최진훈
      </td>
      <td>
         김은경
      </td>
       <td>
         김지훈
      </td>
     <td>
         이동건
      </td>
     <td>
         조재민
      </td>
   </tr>
</table>

## UI 화면구성
**로그인/회원가입**
<table>
   <tr>
      <td>
         <img src= "https://github.com/underdog-FinalProject/carlog/assets/93186591/35b7d751-03b3-4595-b17d-c67ec951e391" />
      </td>
      <td>
         <img src= "https://github.com/underdog-FinalProject/carlog/assets/93186591/a43df5a2-a51f-46c9-ad32-3238169f9109" />
      </td>
      <td>
         <img src= "https://github.com/underdog-FinalProject/carlog/assets/93186591/69585b4e-d619-4b16-9f4b-214e58e6b96c" />
      </td>
      <td>
         <img src= "https://github.com/underdog-FinalProject/carlog/assets/93186591/fac8459d-56b5-41d0-b73d-626f7821e2ad" />
      </td>
   </tr>
   <tr align="center"> 
      <td>
         로그인
      </td>
      <td>
         회원가입
      </td>
      <td>
        주종 선택
      </td>
       <td>
        차량번호 입력<br>
        제조사 입력<br>
        차량명 입력<br>
        닉네임 입력<br>
        최종 주행거리 입력<br>
      </td>
   </tr>
</table>



**MyCarPage**

**HistoryPage**

**MapPage**

**CommunityPage**

**MyPage**

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
