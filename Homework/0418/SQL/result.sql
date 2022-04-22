-- 1. 차량 수 조회
select count(car_number) 
from car_information;

-- 2. 차량에 부착된 디바이스 uuid, battery, create_at 조회. // 조인 해서 다시 

select 
d.device_uuid,
d.battery,
d.create_at
from devices as d  join car_information as c
on d.device_uuid = c.device_uuid;

-- 3. UUID '20130099', 배터리 100, 펌웨어 버전 '1.0.1', 사용여부 TRUE인 디바이스를 devices에 등록하시오.
insert into devices
values (20130099, 100,'1.0.1', 1, now());
commit;


-- 4. 2022-04-11 이후 탈착 이벤트가 1건 이상 발생된 UUID, 펌웨어 버전 조회. *** 언폴츄널리 아돈언덜스탠드

select 
	d.device_uuid,
	d.firmware_ver
from devices as d
inner join car_information as ci
on d.device_uuid = ci.device_uuid
inner join car_event_log as cel
on ci.car_number = cel.car_number
where 
	date_format(cel.create_at, '%Y-%m-%d')  >= '2022-04-11'
	and cel.event_type = '3'
group by d.device_uuid

-- 5. 2022-04-11 ~ 2022-04-13 일별 이벤트 카운트 조회.  

select 
DATE_FORMAT(create_at,'%Y-%m-%d'),
count(*) 
from car_event_log 
group by DATE_FORMAT(create_at,'%Y-%m-%d') 
BETWEEN '2022-04-11' AND '2022-04-13'
group by date_format(create_at, '%Y-%m-%d');

--- 쌤 답안
select 
	d.device_uuid,
	d.firmware_ver
from devices as d
inner join car_information as ci
on d.device_uuid = ci.device_uuid
inner join car_event_log as cel
on ci.car_number = cel.car_number
where 
	date_format(cel.create_at, '%Y-%m-%d')  >= '2022-04-11'
	and cel.event_type = '3'
group by d.device_uuid


-- 6. 전체 디바이스 수, 차량에 부착된 디바이스 수, 차량에 부착하지 않은 디바이스 수 조회.

select 
count(d.device_uuid) as "전체디바이스수",
count(c.device_uuid) as "부착된 디바이스 수 ",
c.device_uuid is null as "미부착 디바이스 수"
from devices d left join car_information c 
on d.device_uuid = c.device_uuid;

-- 7. 차량번호 '359서 9096'의 2022-04-11 ~ 2022-04-13일까지 이벤트별 카운트 조회
select 
  count(*),
  event_type 
from car_event_log
where
	car_number = '359서 9096' 
	and
	date_format(create_at, '%Y-%m-%d') 
	BETWEEN '2022-04-11' AND '2022-04-13'
group by event_type


-- 8. UUID가 '20133344'인 디바이스의 2022-04-11 ~ 2022-04-13에 발생한 이벤트타입, 이벤트 날짜, 차량번호판, 담당자 조회.
select 
	cel.event_type,
	cel.create_at,
	ci.car_number,
	ci.admin_name
from devices as d
inner join car_information as ci
on d.device_uuid = ci.device_uuid
inner join car_event_log as cel
on ci.car_number = cel.car_number
where 
	d.device_uuid = '20133344'
	and 
	date_format(cel.create_at, '%Y-%m-%d') 
	BETWEEN '2022-04-11' AND '2022-04-13'