# Command-Invastigation-Task
## [오픈소스 SW개론 과제 ]  getopt, getopts(Shell) | sed, awk(Linux) 명령어 조사   
---
## 목차
### 1. *Commands In Linux*
* sed
>  1\) sed란?\
>  2\) sed의 특징\
>  3\) sed 옵션\
>  4\) sed 주요 명령어\
>  5\) 정규식표현에 사용되는 sed 메타문자

* awk 
>  1\) awk란?\
>  2\) awk 특징\
>  3\) awk 형식\
>  4\) sed 주요 명령어\
>  5\) 정규식표현에 사용되는 sed 메타문자


### 2. *Commands In Shell Script*
* getopt
* getopts
---
## 1. Commands In Linux - *sed*
### 1) sed란?
>sed (streamlined editor)는 편집에 사용되는 *비 대화형 모드*의 줄 단위 편집기입니다.\
>다른 편집기와 다르게 명령행에서 파일을 인자로 받아 명령어를 통해 작업한 후\
>결과를 화면으로 출력하는 방식입니다.  

### 2) sed의 특징
>쉘 또는 스크립트에서 **파이프(|)** 와 같이 사용될 수 있습니다.\
>기본적으로 **정규표현식이 가능** 하고 이 때문에 특수문자 앞에 역슬래시를 붙여줘야 합니다.\
>ex) `$ sed 's/\$Honam/Honam/g' sed.txt`\
>파일의 **원본을 손상하지 않는** 게 특징입니다.\
>즉, 입력한 명령을 수행한 후 화면으로 출력 되는 결과가 원본과 다르더라도\
> 원본에 손상이 없습니다.


### 3) sed 옵션
|옵션|기능|
|:---|:----------:|
|e|다중 편집 기능|
|i|***변경되는 값을 실제로 파일에 저장, 출력없이 바로 원본에 적용***|
|n|특정 값이 들어간 줄만 출력, 주로 p와 사용|

### 4) sed 주요 명령어
|명령어|설명|예제|
|:---|:----:|:--------------------------:|
|p|줄 출력|`$ sed 'Honam/p' sed.txt`|
|d|현재 줄 삭제|`$ sed '3d' sed.txt`|
|s|문자열 치환|`$ sed 's/Honam/Jeonnam/g' sed.txt`|
|r|파일에서 줄 읽음|`$ sed '/Honam/r newfile' sed.txt`|
|w|줄을 파일에 쓰기|`$ sed -n '/Honam/w newfile' sed.txt`|
|a\\ |현재 줄에 하나 이상의 줄 추가|`$ sed '/^Honam /a\ ###Sample###' sed.txt`|
|c\\ |현재 줄 내용을 새로운 내용으로 치환|`$ sed '/Honam/c\ ###Sample###' sed.txt`|
|i\\ |현재 줄 위에 내용 삽입|`$ sed '/Honam/i\ ###Sample###' sed.txt`|
|g|각 줄 전체에 대해 치환| s 예제 참고|
|y|한 문자를 다른 문자로 변환|`$ sed '/1,3y/abc...xyz/ABC...XYZ/' sed.txt`|
|q|sed 종료|`$ sed '5q' sed.txt`|

 가장 많이 사용되는 p, d, s 명령어만 예제를 통해 설명하겠습니다.
 * _p : 출력 기능_
    * sed -n p <file>: 파일 전체 출력 ('-n'을 붙이지 않으면 모두 중복 돼서 출력 됨)
    * sed 3p <file>: 3번째 줄 한 번 더 출력
    * sed 3,4p <file>: 3,4번째 줄 한 번 더 출력
    * sed /Honam/p <file>: Honam이 포함된 줄 한 번 더 출력
    * sed -n /Honam/p <file>: Honam이 포함된 줄만 출력
 
     <img src ="https://user-images.githubusercontent.com/87132052/142612570-71c113a5-5cc4-4a5d-84da-b990cb901e78.gif" width ="50%" height ="50%">

  
 * _d : 삭제 기능_
    * sed 3d <file>: 3번째 줄 삭제, 나머지 출력
    * sed /Honam/d <file>: Honam이 포함된 줄 삭제, 나머지 출력
    * sed '3, $d' <file>: 3번째~마지막 줄 삭제, 나머지 출력
 
     <img src ="https://user-images.githubusercontent.com/87132052/142612636-64a751f2-b6f7-493e-8671-28718e79e43e.gif" width ="50%" height ="50%">
  
  * _s : 치환 기능_
    * sed 's/Honam/Jeonnam/g' <file>: Honam을 Jeonnam으로 치환
    * sed -n 's/Honam/Jeonnam/p' <file>: Honam을 Jeonnam으로 치환, 치환된 줄 출력
 
    <img src ="https://user-images.githubusercontent.com/87132052/142612719-3ca75eac-d24e-4ed6-91b5-f00b7b4a90f0.GIF" width ="50%" height ="50%">
 
### 5) 정규식표현에 사용되는 sed 메타문자
|메타문자|기능|예제|설명|
|:-----|:------:|:-------------:|:--------------:|
|.|하나의 문자와 일치|`$ sed -n '/.59/p' sed.txt`|59라는 단어가 들어간 줄만 출력|
|^|행의 시작 지시자|`$ sed -n '/^Kim/p' sed.txt`|Kim으로 시작하는 줄 출력|
|*|0개 이상의 문자|`$ sed -n '/ *J/p' sed.txt`|0개 이상의 공백 다음 J가 포함된 줄 출력|
|$|줄의 끝 지시자|`$ sed -n '/nam$/p' sed.txt`|nam으로 끝나는 줄 출력|
|[ ]|괄호 안에 한 문자와 일치|`$ sed -n '/[Hh]o/p' sed.tx`|Ho 또는 ho가 포함된 줄 출력|
|[^ ]|괄호 안에 없는 문자와 일치|`$ sed -n '/[^Hh]w/p' sed.txt`|H 또는 h가 포함되지 않고 w를 포함하는 줄 출력|
|&|검색문을 저장, 치환문으로 기억|`$ sed -n 's/Honam/**&**/p' sed.txt`|Honam -> \**Honam\**으로 변경|

 --- 
 ## 1. Commands In Linux - *awk*
 ### 1) awk?
 > 1997년 AT&T 연구소의 Alfred V. **A**ho, Peter J. **W**einverger, Brian W. **K**ernighan 세 사람이 만들었습니다.\
 > 유닉스에서 개발된 스크립트 언어로 텍스트가 저장되어 있는 데이터 파일을 처리하여\
 > 계산, 통계, 비교 분석, 필터링을 통한 데이터 추출 등 다양하게 사용되며\
 > 리눅스에서 텍스트 처리를 위한 **프로그래밍 언어**입니다.
 
 ### 2) awk의 특징
 > 사용자 정의 함수 및 **정규 표현식 기능**을 지원합니다.\
 > 명령 행에서 사용될 뿐만 아니라 스크립트로 사용합니다.\
 > 배열, 함수 등과 같은 많은 **내장 함수**가 내포되어 있습니다.
 
 ### 3) awk 형식
 ```awk
 $ awk 'pattern' filename
 $ awk '{action}' filename
 $ awk 'pattern {action}' filename
 ```
**pattern, action은 모두 생략 가능합니다.**
> * pattern 생략 (모든 레코드 적용)
>   * ` $ awk '{ print }' ./awk1.txt` 
>   * awk1.txt의 모든 레코드 출력.
> * action 생략 (print 적용)
>   * ` $ awk '/p/' ./awk1.txt`           
>   * awk1.txt에서 p를 포함하는 레코드 출력.
 
### 4) 

 
 
 
 <details>
<summary>출처</summary>
<div markdown="1">       

#### sed 
 > [woolab블로그](https://blog.naver.com/illi0001/140110607926 "naver.blog, 조사일: 2021.11.19.")\
 > [SED스트림에디터](http://korea.gnu.org/manual/release/sed/x110.html "조사일: 2021.11.19.")\
 > [INCODOM](http://www.incodom.kr/Linux/%EA%B8%B0%EB%B3%B8%EB%AA%85%EB%A0%B9%EC%96%B4/sed#h_e77bad097d5ab55f32983c0250f8ada5 "INCODOM, 조사일: 2021.11.19.")
 
 ### awk
 > [해솔](https://shlee1990.tistory.com/487 "Tistory, 조사일: 2021.11.20. ")\
 > [INCODIOM](http://www.incodom.kr/Linux/%EA%B8%B0%EB%B3%B8%EB%AA%85%EB%A0%B9%EC%96%B4/awk, "INCODOM, 조사일: 2021.11.20.")\
 > [개발자를 위한 레시피](https://recipes4dev.tistory.com/171, "Tistory, 조사일: 2021.11.20.")

</div>
</details>
 
