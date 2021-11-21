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
>  3\) awk 옵션\
>  4\) awk 스크립트\
>  5\) awk 사용 예시


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
 
 ### 3) awk의 옵션
|옵션|기능|
|:---|:----------:|
|-u|버퍼를 사용하지 않고 출력|
|-F|확장된 정규 표현식으로 필드구분자 지정, 다중 필드 구분자 사용 가능|
|-v|스크립트 실행 전, 미리 변수를 지정|
|-f|awk 명령 스크립트를 파일에서 읽어옴| 
 
### 4) awk 스크립트
 awk 명령에서 awk program은 
 아래와 같이''(single quotation marks) 안에 작성합니다.

 ```awk
 $ awk 'pattern' filename
 $ awk '{action}' filename
 $ awk 'pattern {action}' filename
 ```
**pattern, action은 모두 생략 가능합니다.**
> * pattern 생략 (모든 레코드(line) 동작 대상)
>   * ` $ awk '{ print }' ./awk1.txt` 
>   * awk1.txt의 모든 레코드 출력.
> * action 생략 (pattern과 일치하는 레코드(line) 출력)
>   * ` $ awk '/p/' ./awk1.txt`           
>   * awk1.txt에서 p를 포함하는 레코드 출력.
 
 pattern과 action에 작성되는 awk program 코드에는 다양한 표현식, 변수, 함수 등이 사용됩니다.\
 이 중 가장 중요한 변수는 *record와 field*를 나타내는 변수입니다.\
 **하나의 record: $0, record 에 포함된 각 field는 순서대로 $1, $2, ..., $n**으로 지칭합니다.\

 <img src = "https://user-images.githubusercontent.com/87132052/142750868-eeca75e5-6338-4a16-b8f1-0bcbd170cf0c.jpg" width="50%" height="50%">
 
  
 #### ① pattern
 **/정규 표현식/**\
 sed가 지원하지 않는*+,|,()* 등의 메타문자도 지원\
 또한 ^,$를 각 필드의 처음과 끝을 의미하도록 사용 가능
 
> |메타문자|기능|
> |:---|:----------:|
> |+|하나의 문자 또는 그 이상|
> |A\|B|OR 연산자 A 또는 B|
> |()|하위표현식, 역참조 가능|
> |^ $ . * \[\] \[^\] & 등|sed 정규 표현식 참고|

 
 **비교 연산**\
 숫자 기준, 알파벳 기준 모두 사용 가능\
 **패턴 매칭 연산**\
 \~: 일치하는 부분 나타냄\
 !\~: 일치하지 않는 부분 나타냄\
 **BEGIN**\
 첫 번째 레코드가 읽혀지기 전에 어떤 동작을 정의하여 실행하고 싶을 때 사용\
 **END**\
 마지막 레코드가 모두 읽혀진 후 어떤 동작을 정의하여 실행하고 싶을 때 사용
 
#### ② action
action은 **모두 \{\}** 로 둘러싸야 함

### 5) awk 사용 예시
* awk1.txt: `$ awk '{print}' awk1.txt`
> <img src = "https://user-images.githubusercontent.com/87132052/142752238-94fb12b6-f7d9-4b5c-8e8e-9a55f1c78564.GIF" width="50%" height="50%">
 
* Honam이 포함되는 행번호와 내용 출력: `$ awk '/Honam/{print "ROW:" NR,$2,$1}' awk1.txt`
> <img src ="https://user-images.githubusercontent.com/87132052/142752330-dcf0526d-1d66-42e8-801e-c779abd7d3f6.GIF" width ="30%" height ="30%">
 
* 첫번째 필드에 Yoo 포함, 1,2번째 필드 출력: `awk '$1~/Yoo/{print$1,$2}' awk1.txt`
> <img src ="https://user-images.githubusercontent.com/87132052/142752540-86e6ebce-6911-4bc2-9fe8-c12e74940652.GIF" width ="30%" height ="30%">

* 5번째 필드의 길이가 5보다 큰 레코드 출력: `awk 'length($5)>5{print}' awk1.txt`
> <img src ="https://user-images.githubusercontent.com/87132052/142752709-995e22e6-08a9-4f30-9787-353bee4857a2.GIF" width ="50%" height ="50%">
 
 --- 
 ---
 ## 2. Commands In Shell Script - *getopt*
 
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
 > [개발자를 위한 레시피](https://recipes4dev.tistory.com/171, "Tistory, 조사일: 2021.11.20.")\
 > [어느해겨울](https://muabow.tistory.com/entry/awk, "Tistory, 조사일: 2021.11.21.")\
 > [IT Vibe](https://m.blog.naver.com/onevibe12/221765285982, "naver Blog, 조사일: 2021.11.21.)
 
 
</div>
</details>
 
