show tables

# orders table�� �ִ� ������ �� ���ҹ���� kakaopay�� ���� ���
select * from orders
where payment_method = 'kakaopay'

# ����Ʈ�� 20000�� �̻��� users ���
select * from point_users
where point > 20000

# �̰� CARD card �Ȱ��� �����
select * from orders
where course_title = '�۰��� ���չ�' and payment_method  = 'CARD'

# ���� �ʴ� !=
select * from orders
where course_title != '�۰��� ���չ�'

# ���� ã�� - 2020�� 7��13�� ���� 2020�� 7�� 14�� �����ʹ� 13�Ϻ��� 15�� ������ ����ش�.
# ��¥�� '2020-07-13' �̵� '20200713', '200713' �̵� ���� ����ȴ�.
# �ƴѵ� between�� ������ �� ���ڱ��� ���Ե�! �̰� �ֱ׷��� ã�ƺ���~!
select * from orders
where date(created_at) BETWEEN '2020-07-13' and '2020-07-14'


select date(created_at) from orders


# ����Ʈ ã�� - 2,3 ������ �ش��ϴ� ������ ����ϱ�
# SELECT ������ ���� ����ϰ� ���� �ʵ尪�� ����
select comment from checkins
where week in (2,3) 

# LIKE - ���� ���� �Ƶ� �ڿ��� daum.net�� ��
select * from users 
where email like '%daum.net'


# ����
# ���� ������ ī�尡 �ƴ� �ֹ� ������ ����
select * from orders
where payment_method != 'CARD'


# ����Ʈ�� 2��-3�� ���� ���� ����
select * from point_users
where point between 20000 and 30000

# �̸����� s�� �����ϰ� com���� ������ ���� �̾��� ���� ����
select * from users
where email like 's%com' and name like '��%'

# LIMIT - ���ǿ� �´� �͵� �� ���� ����
# limit�� ���� 5���� ����Ǵ°�?
select * from orders
where payment_method = 'kakaopay'
limit 5

# DISTINCT - �ߺ����� �� count_values ����
select distinct payment_method from orders 
# Ȥ�� select distinct(payment_method) from orders 


# COUNT - ���ǿ� �´� �ν��Ͻ� ���� ���
select count(*) from orders
where payment_method = 'kakaopay'

# DISTINCT X COUNT - �ߺ��� ������ �ʵ��� ���� ����
select count(*) from (select DISTINCT * from users) t1


# 1-9. ���� Ǯ���

# 1. ���� ������ ������ �̸��ϸ� �����ϱ�
select email from users
where name like '��%'

# 2. gmail�� ����ϴ� 2020/07/12-13�� ������ ������ �����ϱ�
# 7�� 13�� ������ �Ѱܼ� �׷���?
select * from users 
where email like '%gmail.com' 
and created_at between '20200712' and '20200714'

# 2���� ����� �ν��Ͻ��� �� ������ �����
select count(*) from users 
where email like '%gmail.com' 
and created_at between '20200712' and '20200714'


