# 조인해서 kakaopay 조건 건 뒤 원하는 데이터만 뽑기
select u.user_id, u.email, u.name from users u
inner join orders o on u.user_id = o.user_id  
where o.payment_method = 'kakaopay'

# 위의 조건을 subquery화 한다면?
# 서브쿼리란? 큰 쿼리문 안에 들어가 있는 쿼리문. 안에 있는 것을 먼저 실행하고 큰 것을 실행하는 순서로 계산됨.
# where subquery
select user_id, email, name from users u 
where user_id in (
	select user_id from orders o 
	where payment_method = 'kakaopay'
)


# select subquery - 각 아이디 별 평균 like값이 테이블에 보일 수 있도록 지정
select c.checkin_id, 
	   c.user_id, 
	   c.likes, 
	   (
	   	select avg(likes) from checkins 
	   	where user_id = c.user_id 
	   ) as avg_likes_user
	   from checkins c 

	   

	   
# from subquery - 가장 많이 쓰는 유형
select c.user_id, round(avg(c.likes),1) as average_likes from checkins c 
group by user_id 

select pu.user_id, pu.point from point_users pu 


# 위의 두 테이블을 user_id 를 매개로 잇는 방법 - 내부 쿼리 이름을 a라고 지정
# 따로 만든 테이블을 조인!

select pu.user_id, pu.point, a.avg_likes from point_users pu 
inner join (
	select c.user_id, round(avg(c.likes),1) as avg_likes from checkins c 
	group by user_id 
) a on pu.user_id = a.user_id


# 퀴즈 1- 전체 유저의 포인트의 평균보다 큰 유저들의 데이터를 추출해보기

select * from point_users pu 
where pu.point > (
	select avg(point) from point_users
)


# 퀴즈 2- 이씨 성을 가진 유저의 포인트의 평균보다 큰 유저들의 데이터 추출해보기
# 1. 이씨 성을 가진 유저의 포인트 평균 찾기 - 이때 최소한의 데이터를 우선적으로 출력하기 위해 (성능 이슈) 이씨 먼저 출력
# 2. where 절에서 1 테이블 조건 생성해 프린트
# 서브쿼리 내 서브쿼리 - as 없어도 됨

select * from point_users pu2
where pu2.point > (
	select avg(point) from point_users pu 
	inner join (
		select name, user_id from users
		where name like '이%'
	) as u
	on pu.user_id = u.user_id
)


# 퀴즈 3- checkins 테이블에 course_id별 평균 likes 수 필드 우측에 붙여보기
# select subquery에서는 겉 query를 먼저 읽기 때문에 alias 지정 걱정 안해도 됨

select c2.*,
	   (
	   	select avg(likes) from checkins c1
	   	where c1.course_id = c2.course_id 
	   ) as avg_likes
	   from checkins c2
	   

# 퀴즈 4- checkins 테이블에 과목명별 평균 like 수 필드 우측에 붙여보기
# user_id 통해서 조인한 뒤, course_id 별로 groupby해서 평균 like 수를 구하기
# 맞힘

select c2.*, c1.avg_course_likes from checkins c2
left join (
	select course_id, round(avg(likes),1) as avg_course_likes from checkins
	group by course_id 
) c1
on c2.course_id = c1.course_id


# 4번 정답
select checkin_id, c3.title, user_id, likes, 
(select round(avg(c2.likes),1) from checkins c2
where c.course_id = c2.course_id) as course_avg
from checkins c
inner join courses c3 
on c.course_id = c3.course_id;



# 서브쿼리 연습해보기.[준비1] course_id 별 유저의 체크인 개수를 구해보기 - 중복없이!
# 중복없는 값 세는 방법: distinct 를 count() 안에 넣기! 중요
select course_id, count(distinct(user_id)) from checkins c 
group by course_id 


# [준비2] course_id 별 인원을 구해보기
select course_id, count(user_id) as cnt_total from orders o 
group by course_id 



# [한걸음 더] 퍼센트 나타내기
# 위의 준비1, 준비2 를 합쳐보기 + 제목을 보기좋게 바꿔보기

select c2.title,
	   c.cnt_checkins,
	   o.cnt_total,
	   c.cnt_checkins/o.cnt_total as ratio
from (
	select course_id, count(distinct(user_id)) as cnt_checkins 
	from checkins
	group by course_id
) c
inner join (
	select course_id, count(user_id) as cnt_total from orders
	group by course_id
) o
on c.course_id = o.course_id
inner join (
	select * from courses
) c2
on c.course_id = c2.course_id 


