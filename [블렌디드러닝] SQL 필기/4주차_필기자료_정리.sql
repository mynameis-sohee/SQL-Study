# �����ؼ� kakaopay ���� �� �� ���ϴ� �����͸� �̱�
select u.user_id, u.email, u.name from users u
inner join orders o on u.user_id = o.user_id  
where o.payment_method = 'kakaopay'

# ���� ������ subqueryȭ �Ѵٸ�?
# ����������? ū ������ �ȿ� �� �ִ� ������. �ȿ� �ִ� ���� ���� �����ϰ� ū ���� �����ϴ� ������ ����.
# where subquery
select user_id, email, name from users u 
where user_id in (
	select user_id from orders o 
	where payment_method = 'kakaopay'
)


# select subquery - �� ���̵� �� ��� like���� ���̺� ���� �� �ֵ��� ����
select c.checkin_id, 
	   c.user_id, 
	   c.likes, 
	   (
	   	select avg(likes) from checkins 
	   	where user_id = c.user_id 
	   ) as avg_likes_user
	   from checkins c 

	   

	   
# from subquery - ���� ���� ���� ����
select c.user_id, round(avg(c.likes),1) as average_likes from checkins c 
group by user_id 

select pu.user_id, pu.point from point_users pu 


# ���� �� ���̺��� user_id �� �Ű��� �մ� ��� - ���� ���� �̸��� a��� ����
# ���� ���� ���̺��� ����!

select pu.user_id, pu.point, a.avg_likes from point_users pu 
inner join (
	select c.user_id, round(avg(c.likes),1) as avg_likes from checkins c 
	group by user_id 
) a on pu.user_id = a.user_id


# ���� 1- ��ü ������ ����Ʈ�� ��պ��� ū �������� �����͸� �����غ���

select * from point_users pu 
where pu.point > (
	select avg(point) from point_users
)


# ���� 2- �̾� ���� ���� ������ ����Ʈ�� ��պ��� ū �������� ������ �����غ���
# 1. �̾� ���� ���� ������ ����Ʈ ��� ã�� - �̶� �ּ����� �����͸� �켱������ ����ϱ� ���� (���� �̽�) �̾� ���� ���
# 2. where ������ 1 ���̺� ���� ������ ����Ʈ
# �������� �� �������� - as ��� ��

select * from point_users pu2
where pu2.point > (
	select avg(point) from point_users pu 
	inner join (
		select name, user_id from users
		where name like '��%'
	) as u
	on pu.user_id = u.user_id
)


# ���� 3- checkins ���̺� course_id�� ��� likes �� �ʵ� ������ �ٿ�����
# select subquery������ �� query�� ���� �б� ������ alias ���� ���� ���ص� ��

select c2.*,
	   (
	   	select avg(likes) from checkins c1
	   	where c1.course_id = c2.course_id 
	   ) as avg_likes
	   from checkins c2
	   

# ���� 4- checkins ���̺� ����� ��� like �� �ʵ� ������ �ٿ�����
# user_id ���ؼ� ������ ��, course_id ���� groupby�ؼ� ��� like ���� ���ϱ�
# ����

select c2.*, c1.avg_course_likes from checkins c2
left join (
	select course_id, round(avg(likes),1) as avg_course_likes from checkins
	group by course_id 
) c1
on c2.course_id = c1.course_id


# 4�� ����
select checkin_id, c3.title, user_id, likes, 
(select round(avg(c2.likes),1) from checkins c2
where c.course_id = c2.course_id) as course_avg
from checkins c
inner join courses c3 
on c.course_id = c3.course_id;



# �������� �����غ���.[�غ�1] course_id �� ������ üũ�� ������ ���غ��� - �ߺ�����!
# �ߺ����� �� ���� ���: distinct �� count() �ȿ� �ֱ�! �߿�
select course_id, count(distinct(user_id)) from checkins c 
group by course_id 


# [�غ�2] course_id �� �ο��� ���غ���
select course_id, count(user_id) as cnt_total from orders o 
group by course_id 



# [�Ѱ��� ��] �ۼ�Ʈ ��Ÿ����
# ���� �غ�1, �غ�2 �� ���ĺ��� + ������ �������� �ٲ㺸��

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


