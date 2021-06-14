show tables


# �̸� �� �� ���� �ִ��� ����
# group by: ���� �Ӽ����� ����
# 1. users���� 2. group by�� ��, 3. select
select name, count(*) from users
group by name


# �ž��� ������� ���� ���� ���� ���
# SQL Error [1064] [42000]: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'where name='��**'' at line 2
select name, count(*) from users
group by name where name='��**'

# ����. �׷��� ���� �ʿ䰡 ����, �ž��� ����鸸 ����� count�ϸ� ��
select name, count(*) from users
where name='��**'

# ���� �� ������ ���� ���ϱ�
# limit 10
select week, count(*) from checkins 
group by week

# ������ ���� like �ּҰ� ���ϱ�
select week, min(likes) from checkins
group by week 

# ������ ���� like �ִ밪 ���ϱ�
select week, max(likes) from checkins
group by week

# ������ ���� like ��հ� ���ϱ� + �ݿø�
select week, round(avg(likes)) from checkins
group by week

# ������ ���� like �� ���ϱ� + �ݿø�
select week, sum(likes) from checkins
group by week


# ���� �� �� ���� �ִ��� ���� + �������� ����(asc, default)
select name, count(*) from users
group by name
order by count(*)

# ���� �� �� ���� �ִ��� ���� + �������� ����(desc)
select name, count(*) from users
group by name
order by count(*) desc

# �̸����� ������������ ���ڿ� ����
select * from users
order by email 

# �����ݷ�: ���� ǥ���ϴ� ��.

# ������ ���չ��� �����ϴ� �л����� ���� ��� �� ������ ������������ ���̱�
# ����: where -> group by -> select -> order by
select payment_method, count(*) from orders
where course_title like '������%'
group by payment_method
order by count(*) desc


# ���� ������ ���� - group by ���ְ��� � �Ӽ����� �ǹ��ϴ��� ������ ���� ��
# select ���� �ݵ��, group by�� ���� �Ӽ��� �ۼ����ش�.
select count(*) from orders
group by payment_method 


### ����
# 1. �۰��� ���չ��� �������� �� �ֹ��Ǽ� �����

select payment_method, count(*) from orders
where course_title = '�۰��� ���չ�'
group by payment_method 

# 2. gmail�� ����ϴ� ���� �� ȸ���� �����
select name, count(*) from users
where email like '%gmail.com'
group by name

# 3. course_id �� ������ ������ �޸� ��� like ���� ���غ���
select course_id, round(avg(likes)) from checkins 
group by course_id 


# ��Ī Alias
select count(*) from orders o
where o.course_title = '�۰��� ���չ�'

select count(*) from orders as o
where o.course_title = '�۰��� ���չ�'

select count(*) as cnt from orders o
where o.course_title = '�۰��� ���չ�'


# ����
# ���̹� �̸����� ����Ͽ� �۰��� ���չ��� ��û�� �ֹ��� �������� �� �ֹ��Ǽ� �����
select payment_method, count(*) as cnt from orders
where email like '%naver.com' and course_title = '�۰��� ���չ�'
group by payment_method 