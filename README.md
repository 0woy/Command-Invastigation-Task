# Command-Invastigation-Task
## [오픈소스 SW개론]  getopt, getopts(Shell) | sed, awk(Linux) 명령어 조사   
---
## 목차
### 1. *Commands In Shell Script*
* getopt
>  1\) 왜 getopt를 사용하나요?\
>  2\) getopt 사용하기\
>  3\) getopt 명령을 스크립트에서 사용하기
* getopts
>  1\) getopt VS getopts\
>  2\) getopts 사용하기\
>  3\) getopts 명령을 스크립트에서 사용하기

### 2. *Commands In Linux*
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
---
---
 ## 1. Commands In Shell Script - *getopt*
 ### 1) 왜 getopt를 사용하나요?
 > 명령어 라인에 입력으로 옵션이 조합으로 입력 되는 경우가 있습니다.\
 > 예를 들어 `$ ls -al`과 같이 옵션이 여러개 붙어서 쓰는 경우엔 스크립트 상에서 처리가 되지 않습니다.\
 > 이럴 경우에 사용하는 유용한 명령어가 **getopt** 입니다. 
 
 ### 2) getopt 사용하기
 명령어 사용 구문: `$ getopt optstring parameters`
 * optstring: 옵션으로 사용될 문자들로 구성된 문자열
 
 <img src ="https://user-images.githubusercontent.com/87132052/142755320-802a74bf-dbe0-48dd-860d-98a5c9c7dee6.GIF" width ="50%" height ="50%">
 
 > 위 예제는 ab:cd 형식을 옵션으로 정의하였습니다.\
 > b 뒤의 **콜론(:)** 은 b 옵션이 **매개변수를 필요**로 함을 나타냅니다.\
 > 명령이 실행되면 주어진 매개변수 목록을 검사하고 optstring을 기준으로 각 요소를 분리합니다.\
 > \-cd 옵션은 자동으로 두 개의 개별 옵션으로 구분되었고\
 > 추가 매개변수를 분리하는 **이중대시(--)** 도 자동으로 들어간 것을 확인할 수 있습니다.

 ### 3) getopt 명령을 스크립트에서 사용하기
  현재의 옵션과 파라미터 값을 getopt 명령의 출력 형식으로 바꾸는 방법중\
  set 명령에서 더블 대쉬(--) 변수를 getopt로 변경을 하면 명령어에 입력되는 옵션과 파라미터가 getopt 명령어 형식으로 처리가 됩니다.
 ```bash
#!/bin/bash

set -- $(getopt -q ab:c "$@")

while [ -n "$1" ]
do
        case "$1"  in
        -a) echo "find -a option";;
        -b) para="$2"
            echo "find -b opt, with para value $para"
            shift;;
        -c) echo "find -c option";;
        --) shift
            break;;
        *) echo "$1 is not an option";;

        esac
        shift
done

count=1;
for para in "$@"
do
echo "parameter #$count:$para"
count=$[ $count + 1 ]
done
```
① `$ ./getopt_ex.sh -ac`
> <img src ="https://user-images.githubusercontent.com/87132052/142756534-cf245fed-45a6-4fce-a319-49c49cabe706.GIF" width="50%" height="50%">

② `$ ./getopt_ex.sh -a -b arg1 -c -d "arg2 arg3" arg4`
> <img src ="https://user-images.githubusercontent.com/87132052/142757191-0045f66e-ad05-4da8-b41b-f46117093701.GIF" widht="50%" height="50%">
---
 ## 1. Commands In Shell Script - *getopts*
 ### 1) geopt VS getopts
 getopt 명령은 따옴표 안에 있는 **빈 칸도 매개변수 구분자로 해석**하기 때문에(위 ②번 참고)\
 빈 칸과 따옴표를 사용하는 매개변수 값을 처리하기에는 좋지 않습니다.\
 이 문제를 해결하기 위해서는 기능이 확장된 **getopts 명령**을 사용하면 됩니다.
 
 ### 2) getopts 사용하기
 명령어 사용 구문: `getopts OptionString Name [ Argument ...]`\
 getopts는 2개의 환경변수를 사용합니다.\
 그 중 하나는 **OPTARG** 변수이고, 이 변수는 *옵션의 파라미터로 사용되는 값을 저장*합니다.\
 **OPTIND** 변수는 파라미터 리스트에서 *getopts가 떠난 위치를 저장*해주고,\
 이 변수 값을 사용해서 처리 후 다시 마지막 위치로 돌아와 다음 파라미터를 처리합니다.\
 
### 3) getopts 명령을 스크립트에서 사용하기
 ```bash
 #!/bin/bash

while getopts :ab:cd opt
do
        case "$opt" in
        a) echo "find the -a option";;
        b) echo "find the -b option, with value $OPTARG";;
        c) echo "find the -c option";;
        d) echo "find the -d option";;
        *) echo "Unknown option: $opt";;
        esac
done

        shift $[ $OPTIND - 1] #OPTIND(getopts의 현 위치)를 처음으로 돌립니다.
count=1
for para in "$@"
do
        echo "Parameter $count: $para"
        count=$[ $count + 1 ]
done
 ```
* ex) `$ ./getopts_ex.sh -a -b arg1 -c -d "arg2 arg3" arg4`
> <img src ="https://user-images.githubusercontent.com/87132052/142757986-7a688fe4-caba-466d-80eb-11ad7533956d.GIF" widht="50%" height="50%">
> getopt와 달리 arg2, arg3가 구분되어 출력되지 않음을 볼 수 있습니다.

---
---
## 2. Commands In Linux - *sed*
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
 * ___p : 출력 기능___
    * sed -n p <file>: 파일 전체 출력 ('-n'을 붙이지 않으면 모두 중복 돼서 출력 됨)
    * sed 3p <file>: 3번째 줄 한 번 더 출력
    * sed 3,4p <file>: 3,4번째 줄 한 번 더 출력
    * sed /Honam/p <file>: Honam이 포함된 줄 한 번 더 출력
    * sed -n /Honam/p <file>: Honam이 포함된 줄만 출력
 
     <img src ="https://user-images.githubusercontent.com/87132052/142612570-71c113a5-5cc4-4a5d-84da-b990cb901e78.gif" width ="50%" height ="50%">

  
 * ___d : 삭제 기능___
    * sed 3d <file>: 3번째 줄 삭제, 나머지 출력
    * sed /Honam/d <file>: Honam이 포함된 줄 삭제, 나머지 출력
    * sed '3, $d' <file>: 3번째~마지막 줄 삭제, 나머지 출력
 
     <img src ="https://user-images.githubusercontent.com/87132052/142612636-64a751f2-b6f7-493e-8671-28718e79e43e.gif" width ="50%" height ="50%">
  
  * ___s : 치환 기능___
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
 ## 2. Commands In Linux - *awk*
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
> * __pattern 생략__ (모든 레코드(line) 동작 대상)
>   * ` $ awk '{ print }' ./awk1.txt` 
>   * awk1.txt의 모든 레코드 출력.
> * __action 생략__ (pattern과 일치하는 레코드(line) 출력)
>   * ` $ awk '/p/' ./awk1.txt`           
>   * awk1.txt에서 p를 포함하는 레코드 출력.
 
 pattern과 action에 작성되는 awk program 코드에는 다양한 표현식, 변수, 함수 등이 사용됩니다.\
 이 중 가장 중요한 변수는 *record와 field*를 나타내는 변수입니다.\
 **하나의 record: $0, record 에 포함된 각 field는 순서대로 $1, $2, ..., $n**으로 지칭합니다.\

 <img src = "https://user-images.githubusercontent.com/87132052/142750868-eeca75e5-6338-4a16-b8f1-0bcbd170cf0c.jpg" width="50%" height="50%">
 
  
 #### ① pattern
 **/정규 표현식/**\
 sed가 지원하지 않는 **\+, \|, \(\)** 등의 메타문자도 지원\
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
 
 <details>
<summary>출처</summary>
<div markdown="1">     
 
> 링크에 마우스를 갖다 대시면 사이트명과 조사일을 확인하실 수 있습니다.\
> 출처를 방문하시면 보다 자세한 정보를 확인하실 수 있습니다.
 
### getopt, getopts
> [트리스탄](https://blog.naver.com/ppp0183/222396804709, "naver Blog, 조사일: 2021.11.21.")\
> [데브로맨스](https://devromance.tistory.com/13, "Tistory, 조사일: 2021.11.21.")\
> [IBM- getopts](https://www.ibm.com/docs/ko/aix/7.2?topic=g-getopts-command, "IBM, 조사일: 2021.11.21.")

### sed 
 > [woolab블로그](https://blog.naver.com/illi0001/140110607926 "naver.blog, 조사일: 2021.11.19.")\
 > [SED스트림에디터](http://korea.gnu.org/manual/release/sed/x110.html "조사일: 2021.11.19.")\
 > [INCODOM](http://www.incodom.kr/Linux/%EA%B8%B0%EB%B3%B8%EB%AA%85%EB%A0%B9%EC%96%B4/sed#h_e77bad097d5ab55f32983c0250f8ada5 "INCODOM, 조사일: 2021.11.19.")
 
 ### awk
 > [해솔](https://shlee1990.tistory.com/487 "Tistory, 조사일: 2021.11.20. ")\
 > [INCODIOM](http://www.incodom.kr/Linux/%EA%B8%B0%EB%B3%B8%EB%AA%85%EB%A0%B9%EC%96%B4/awk, "INCODOM, 조사일: 2021.11.20.")\
 > [개발자를 위한 레시피](https://recipes4dev.tistory.com/171, "Tistory, 조사일: 2021.11.20.")\
 > [어느해겨울](https://muabow.tistory.com/entry/awk, "Tistory, 조사일: 2021.11.21.")\
 > [IT Vibe](https://m.blog.naver.com/onevibe12/221765285982, "naver Blog, 조사일: 2021.11.21.")
 
 ###### [Chosun Univ.] 20203169 컴퓨터공학과 박윤아
 
</div>
</details>
 
