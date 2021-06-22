show tables

# 테이블을 나눠놓는 이유
# 한 목적에 맞는 것들만 보관하는 것이 가장 좋다. 간편하고 나중에 수정하고 싶을때를 대비

# 무엇으로 테이블을 join하는가? 기준 하나(key)를 갖고 테이블을 join한다
# 조인 종류: left join(왼쪽 기준으로 join-가장먼저 나온게 왼쪽인것같음), inner join(교집합)
# on : join할 값의 대상

select * from point_users
left join users
on point_users.user_id = users.user_id


# 코드 실행 순서. from 뒤. join 진행. 테이블 붙은 상태에서 select
select * from orders o 
inner join users u
on o.user_id = u.user_id 


# checkins 테이블에 courses 테이블 연결해서 통계치 내어보기

# 1. 오늘의 다짐 정보에 과목 정보를 연결해 과목별 오늘의다짐 갯수를 세어보기
select title, count(*) as cnt from checkins c1
inner join courses c2 
on c1.course_id = c2.course_id 
group by c2.title


# 2. 많은 포인트를 얻은 순서대로 유저 데이터 정렬해서 보기
select pu.user_id, u.name, u.email, pu.point from point_users pu 
inner join users u 
on pu.user_id =u.user_id 
order by pu.`point` desc

# 3. 네이버 이메일 사용하는 유저의 성씨 별 주문건수 세어보기

select u.name, count(*) as cnt from users u
inner join orders o 
on u.user_id = o.user_id 
where u.email like '%@naver.com'
group by u.name

# 쿼리 실행 순서: from join where groupby select



# 퀴즈1. 결제수단 별 유저 포인트의 평균값 구해보기
# SQL Error [1064] [42000]: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '*)
select o.payment_method, avg(*) from orders o 
inner join point_users pu on pu.user_id = o.user_id
group by o.payment_method

# 퀴즈1. 결제수단 별 유저 포인트의 평균값 구해보기
select o.payment_method, round(avg(pu.point)) from orders o 
inner join point_users pu on pu.user_id = o.user_id
group by o.payment_method 


# 퀴즈2. 결제하고 시작하지 않은 유저들을 성씨별로 세어보기
select name, count(*) as cnt from enrolleds e
inner join users u 
on e.user_id = u.user_id 
where e.is_registered = 0
group by u.name 
order by cnt desc


# 퀴즈3. 과목 별로 시작하지 않은 유저들을 세어보기
select c.course_id, c.title, count(*) as cnt_notstart from courses c
inner join enrolleds e 
on c.course_id = e.course_id 
where e.is_registered = 0
group by c.course_id 


# 퀴즈4. 웹개발, 앱개발 종합반의 week별 체크인 수를 세어보기
select c1.title, c2.week, count(*) as cnt from courses c1
inner join checkins c2
on c1.course_id = c2.course_id 
group by c1.title, c2.week
order by c1.title, c2.week

# 퀴즈5. 연습 4번에서, 8월 1일 이후에 구매한 고객들만 골라 보기
select c1.title, c2.week, count(*) as cnt from courses c1
inner join checkins c2 
on c1.course_id = c2.course_id
inner join orders o 
on c2.user_id = o.user_id 
where date(o.created_at) >= '20200801'
group by c1.title, c2.week 
order by c1.title, c2.week


# 퀴즈6. left 한쪽에 없는 것 합치고 싶을 때
# 7월 10일 - 7월 19일에 가입한 고객(created_at) 중, 포인트를 가진(left_join) 고객(on user_id)의 숫자, 그리고 전체 숫자, 그리고 비율을 보기

# HINT : count는 null 을 세지 않는다.
# 만약 ratio를 그냥 null_cnt/total_cnt로 하면 왜안돼?
select count(pu.`point`) as null_cnt,
	   count(u.user_id) as total_cnt,
	   count(pu.`point`)/count(u.user_id) as ratio
 from users u 
 left join point_users pu
 on u.user_id = pu.user_id
where (date(u.created_at) BETWEEN '20200710' and '20200719')

# 질문: count(*)과 count(user_id)의 속도성능차이가존재하는가?



# Union 사용
# Union 이전에 order by를 하는 건 안먹힘. 하고나서 orderby해줘야함

(select '8월' as month, c1.title, c2.week, count(*) as cnt from courses c1
inner join checkins c2 on c1.course_id = c2.course_id
inner join orders o on c2.user_id = o.user_id
where o.created_at < '2020-08-01'
group by c1.title, c2.week
order by c1.title, c2.week)
union all
(select '8월' as month, c1.title, c2.week, count(*) as cnt from courses c1
inner join checkins c2 on c1.course_id = c2.course_id
inner join orders o on c2.user_id = o.user_id
where date(o.created_at) >= '2020-08-01'
group by c1.title, c2.week
order by c1.title, c2.week)


# 숙제
# enrolled_id 별 수강완료 한 강의 갯수를 세어보고, 완료한 강의 수가 많은 순서대로 정렬
select ed.enrolled_id, e.user_id, count(*) as cnt from enrolleds_detail ed 
inner join enrolleds e 
on ed.enrolled_id = e.enrolled_id
where ed.done = 1
group by ed.enrolled_id
order by cnt desc
