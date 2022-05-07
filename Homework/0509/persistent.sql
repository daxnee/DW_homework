--  문제 3. 급여가 가장 높은 사원 조회
	select
	ENAME,
	sal 
	from (
		select 
			max(sal) as maxSal
			from emp
			where date_format(HIREDATE, '%m') = '12'
		)as e,
		emp
		where sal = e.maxSal
		and date_format(HIREDATE,'%m') = '12' 
		

        