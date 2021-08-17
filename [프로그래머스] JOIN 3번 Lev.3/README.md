## **SQL 고득점 Kit - 오랜 기간 보호한 동물(1) 문제**


&nbsp;


#### 레벨 및 출처 
3레벨, 프로그래머스

https://programmers.co.kr/learn/courses/30/parts/17046


&nbsp;


#### 정답 여부
**정답**

&nbsp;

#### 문제 설명

ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. 

ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

![image](https://user-images.githubusercontent.com/79372217/129712001-2c98eb2c-aa36-4ce4-8aab-3f2e29d79fc0.png)



&nbsp;

ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. 

ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.

![image](https://user-images.githubusercontent.com/79372217/129712084-9616d6f4-d5d9-499d-a9fe-5adf9dd1874b.png)


&nbsp;


**아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.**


&nbsp;

