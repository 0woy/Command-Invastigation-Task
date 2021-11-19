# Command-Invastigation-Task
## [오픈소스 SW개론 과제 ]  getopt, getopts(Shell) | sed, awk(Linux) 명령어 조사   
---
### 목차
#### 1. *Commands In Linux*
> * sed
> * awk 

#### 2. *Command In Shell Script*
> * getopt
> * getopts
---
## 1. Command In Linux - *sed*
### 1) sed란?
>sed (streamlined editor)는 편집에 사용되는 명령어입니다.\
>다른 편집기와 다르게 명령행에서 파일을 인자로 받아 명령어를 통해 작업한 후\
>결과를 화면으로 출력하는 방식이며, 파일의 원본을 손상하지 않는 게 특징입니다.\
>즉, 입력한 명령을 수행한 후 화면으로 출력 되는 결과가 원본과 다르더라도\
>원본에 손해가 없습니다.

### 2) sed 옵션
|옵션|기능|
|:---|:----------:|
|e|다중 편집 기능|
|i|변경되는 값을 실제로 파일에 저장|
|n|특정 값이 들어간 줄만 출력, 주로 p와 사용|

### 3) sed 주요 명령어
|명령어|설명|예제|
|:---|:----:|:--------------------------:|
|p|줄 출력|sed 'Honam/p' sed.txt|
|d|현재 줄 삭제|sed '3d' sed.txt|
|s|문자열 치환|sed 's/Honam/Jeonnam/g' sed.txt|
|r|파일에서 줄 읽음|sed '/Honam/r newfile' sed.txt|
|w|줄을 파일에 쓰기|sed -n '/Honam/w newfile' sed.txt|
|a\\ |현재 줄에 하나 이상의 줄 추가|sed '/^Honam /a\ ###Sample###' sed.txt|
|c\\ |현재 줄 내용을 새로운 내용으로 치환|sed '/Honam/c\ ###Sample###' sed.txt|
|i\\ |현재 줄 위에 내용 삽입|sed '/Honam/i\ ###Sample###' sed.txt|
|g|각 줄 전체에 대해 치환| s 예제 참고|
|y|한 문자를 다른 문자로 변환|sed '/1,3y/abc...xyz/ABC...XYZ/' sed.txt|
|q|sed 종료|sed '5q' sed.txt|

 가장 많이 사용되는 p, d, s 명령어만 예제를 통해 설명하겠습니다.
 * _p : 출력 기능_
    * sed p <file>: 파일 전체 출력
    * sed 3p <file>: 3번째 줄 한 번 더 출력
    * sed 3,4p <file>: 3,4번째 줄 한 번 더 출력
    * sed /Honam/p <file>: Honam이 포함된 줄 한 번 더 출력
    * sed -n /Honam/p <file>: Honam이 포함된 줄만 출력
  
 * _d : 삭제 기능_
    * sed 3d <file>: 3번째 줄 삭제, 나머지 출력
    * sed /Honam/d <file>: Honam이 포함된 줄 삭제, 나머지 출력
    * sed '3, $d' <file>: 3번째~마지막 줄 삭제, 나머지 출력
  
  * _s : 치환 기능_
    * sed 's/Honam/Jeonnam/g' <file>: Honam을 Jeonnam으로 치환
    * sed -n 's/Honam/Jeonnam/p' <file>: Honam을 Jeonnam으로 치환, 치환된 줄 출력
