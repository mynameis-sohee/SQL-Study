show tables


# 이름 별 몇 명이 있는지 집계
# group by: 기준 속성으로 묶임
# 1. users에서 2. group by한 뒤, 3. select
select name, count(*) from users
group by name


# 신씨인 사람들의 수를 세고 싶은 경우
# SQL Error [1064] [42000]: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'where name='신**'' at line 2
select name, count(*) from users
group by name where name='신**'

# 정답. 그룹을 묶을 필요가 없이, 신씨인 사람들만 출력패 count하면 됨
select name, count(*) from users
where name='신**'

# 주차 별 오늘의 다짐 구하기
# limit 10
select week, count(*) from checkins 
group by week

# 오늘의 다짐 like 최소값 구하기
select week, min(likes) from checkins
group by week 

# 오늘의 다짐 like 최대값 구하기
select week, max(likes) from checkins
group by week

# 오늘의 다짐 like 평균값 구하기 + 반올림
select week, round(avg(likes)) from checkins
group by week

# 오늘의 다짐 like 합 구하기 + 반올림
select week, sum(likes) from checkins
group by week


# 성씨 별 몇 명이 있는지 집계 + 오름차순 정렬(asc, default)
select name, count(*) from users
group by name
order by count(*)

# 성씨 별 몇 명이 있는지 집계 + 내림차순 정렬(desc)
select name, count(*) from users
group by name
order by count(*) desc

# 이메일을 오름차순으로 문자열 정렬
select * from users
order by email 

# 세미콜론: 끝을 표시하는 것.

# 웹개발 종합반을 수강하는 학생들의 지불 방법 별 개수를 내림차순으로 보이기
# 순서: where -> group by -> select -> order by
select payment_method, count(*) from orders
where course_title like '웹개발%'
group by payment_method
order by count(*) desc


# 자주 나오는 에러 - group by 범주값이 어떤 속성값을 의미하는지 나오지 않을 때
# select 문에 반드시, group by한 기준 속성을 작성해준다.
select count(*) from orders
group by payment_method 


### 퀴즈
# 1. 앱개발 종합반의 결제수단 별 주문건수 세어보기

select payment_method, count(*) from orders
where course_title = '앱개발 종합반'
group by payment_method 

# 2. gmail을 사용하는 성씨 별 회원수 세어보기
select name, count(*) from users
where email like '%gmail.com'
group by name

# 3. course_id 별 오늘의 다짐에 달린 평균 like 개수 구해보기
select course_id, round(avg(likes)) from checkins 
group by course_id 


# 별칭 Alias
select count(*) from orders o
where o.course_title = '앱개발 종합반'

select count(*) from orders as o
where o.course_title = '앱개발 종합반'

select count(*) as cnt from orders o
where o.course_title = '앱개발 종합반'


# 숙제
# 네이버 이메일을 사용하여 앱개발 종합반을 신청한 주문의 결제수단 별 주문건수 세어보기
select payment_method, count(*) as cnt from orders
where email like '%naver.com' and course_title = '앱개발 종합반'
group by payment_method 