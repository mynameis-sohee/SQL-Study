show tables

# orders table에 있는 데이터 중 지불방법이 kakaopay인 것을 출력
select * from orders
where payment_method = 'kakaopay'

# 포인트가 20000점 이상인 users 출력
select * from point_users
where point > 20000

# 이거 CARD card 똑같이 적용됨
select * from orders
where course_title = '앱개발 종합반' and payment_method  = 'CARD'

# 같지 않다 !=
select * from orders
where course_title != '앱개발 종합반'

# 범위 찾기 - 2020년 7월13일 부터 2020년 7월 14일 데이터는 13일부터 15일 범위로 잡아준다.
# 날짜는 '2020-07-13' 이든 '20200713', '200713' 이든 같게 적용된다.
# 아닌데 between은 마지막 쓴 숫자까지 포함돼! 이거 왜그런가 찾아보자~!
select * from orders
where date(created_at) BETWEEN '2020-07-13' and '2020-07-14'


select date(created_at) from orders


# 포인트 찾기 - 2,3 주차에 해당하는 데이터 출력하기
# SELECT 옆에는 내가 출력하고 싶은 필드값을 지정
select comment from checkins
where week in (2,3) 

# LIKE - 앞이 뭐가 됐든 뒤에가 daum.net인 것
select * from users 
where email like '%daum.net'


# 퀴즈
# 결제 수단이 카드가 아닌 주문 데이터 추출
select * from orders
where payment_method != 'CARD'


# 포인트가 2만-3만 보유 유저 추출
select * from point_users
where point between 20000 and 30000

# 이메일이 s로 시작하고 com으로 끝나며 성이 이씨인 유저 추출
select * from users
where email like 's%com' and name like '이%'

# LIMIT - 조건에 맞는 것들 중 개수 제한
# limit는 상위 5개가 추출되는가?
select * from orders
where payment_method = 'kakaopay'
limit 5

# DISTINCT - 중복제거 한 count_values 추출
select distinct payment_method from orders 
# 혹은 select distinct(payment_method) from orders 


# COUNT - 조건에 맞는 인스턴스 개수 계산
select count(*) from orders
where payment_method = 'kakaopay'

# DISTINCT X COUNT - 중복을 제거한 필드의 개수 추출
select count(*) from (select DISTINCT * from users) t1


# 1-9. 퀴즈 풀어보기

# 1. 성이 남씨인 유저의 이메일만 추출하기
select email from users
where name like '남%'

# 2. gmail을 사용하는 2020/07/12-13에 가입한 유저를 추출하기
# 7월 13일 자정을 넘겨서 그런가?
select * from users 
where email like '%gmail.com' 
and created_at between '20200712' and '20200714'

# 2번의 경우의 인스턴스가 몇 개인지 세어보기
select count(*) from users 
where email like '%gmail.com' 
and created_at between '20200712' and '20200714'


