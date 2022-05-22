### 컨트롤러
```java
//문제 0. 급여 1500을 파라미터로 받고 부서가 10, 30에 속하는 사원 중 급여가 1500을 넘는 사원의 이름 및 급여 조회.
@GetMapping("/emp/sal/{sal}")
select
from emp
where sal = #{sal}
and deptno in(10, 30)


-- xml -- 
<select id="selectWhereSalAndDeptno" resultType="Empvo">
		ENAME,
		SAL 
	FROM 
		emp
	WHERE 
		DEPTNO in (10,30)
		AND SAL > #{sal}
</select> 


-- mapper --
public List<EmpVO> selectWhereSalAndDeptno(int sal);

-- service --
public List<EmpVO> getEmpSalAndDeptno(int sal){
		return empMapper.selectWhereSalAndDeptno(sal);
	}

-- controller - 

@GetMapping("/emp/sal/{sal}")
	public List<EmpVO> callEmpSalAndDeptno(@PathVariable("sal") int sal){
		return empService.getEmpSalAndDeptno(sal);
	}



//문제 1. emp에서 사수가 없는 사원 조회
@GetMapping("/emp/mgr")

-- xml -- 
  <select id="selectMgrNull" resultType="EmpVO">
	 SELECT 
		empno,
		ename,
		job,
		sal
	 FROM 
	 	emp 
	 WHERE 
	 	mgr is null
	 </select>

-- mapper --
public List<EmpVO> selectMgrNull();


-- service --
public List<EmpVO> getEmpMgr(){
		return empMapper.selectMgrNull();
	}

-- controller - 

@GetMapping("/emp/mgr")
	public List<EmpVO> callEmpMgr(){
		return empService.getEmpMgr();
	}


//문제 2. 1987년도를 파리미터로 받고 해당 년도에 입사한 사원 조회 
// But, 1987년에 입사한 사원 수가 3명 이하면 1981년에 입사한 사원으로 조회하시오.
@GetMapping("/emp/hiredate/year/{year}")

-- xml -- 
  <select id="selectEmphiredate" resultType="EmpVO">
	 SELECT 
		empno,
		ename,
		job,
		sal,
		hiredate
	 FROM 
	 	emp
	 WHERE 
	 	date_format(HIREDATE, '%y') = #{HIREDATE}
	 	
	 </select>

-- mapper --
	public List<EmpVO> selectEmpHiredate(String hiredate);


-- service --
	public List<EmpVO> getEmphiredate(String hiredate){
		int count =0;
		for(int i=0; i<empMapper.selectEmpHiredate(hiredate).size(); i++){
			count++;
		}
		if(count <= 3){
			hiredate = 1981;
			return empMapper.selectEmpHiredate(hiredate);
		}
		return empMapper.selectEmpHiredate(hiredate);
	}

-- controller - 

@GetMapping("/emp/hiredate/year/{year}")
	public List<EmpVO> callEmpHiredate(@PathVariable("year") String hiredate){
		return empService.getEmphiredate(hiredate);
	}


//문제 3. 12월을 파라미터로 받고 해당 월에 입사한 사원 중 급여가 가장 많은 사원 조회
// hint : 입사날짜가 12월인 사람들을 list를 담아라
@GetMapping("/emp/hiredate/month/{month}")

-- xml -- 

-- 서브쿼리,service로직x -- 
	<select id="selectEmpMaxSal" resultType="EmpVO">
	    select 
      ENAME, 
      sal 
    from 
      (
        select 
          max(sal) as maxSal 
        from 
          emp 
        where 
          date_format(HIREDATE, '%m') = #{HIREDATE}
          ) as e, 
     	 emp 
    where 
		sal = e.maxSal 
		and date_format(HIREDATE, '%m') = #{HIREDATE}
	</select>

-- service 사용 xml -- 
<select id="selectEmpMaxSal" resultType="EmpVO">
	SELECT 
		ename,
		job,
		hiredate ,
		sal
	FROM 
		emp  
	WHRER 
		date_format(HIREDATE, '%m')=#{month} 
</select>


-- mapper --
	public List<EmpVO> selectEmpMaxSal(String hiredate);


-- service --
public List<EmpVO> getEmpMaxSal(String hiredate){
	int max = 0;
		List<EmpVO> list = empMapper.getHiredateMonth(month);
		EmpVO vo = null;
		System.out.println(list);
		for(int i=0; i<list.size(); i++) {
			if(max<list.get(i).getSal()){
				max = list.get(i).getSal();
				if(max == list.get(i).getSal()) {
					vo = list.get(i);
				}
			}
		}
		List<EmpVO> maxSalEmpnoList = new ArrayList<EmpVO>();
		maxSalEmpnoList.add(vo);
		System.out.println(maxSalEmpnoList);
		return maxSalEmpnoList;
	}
		


-- controller - 

@GetMapping("/emp/hiredate/month/{month}")
	public List<EmpVO> callEmpMaxSal(String hiredate){
		return empService.getEmpMaxSal(hiredate);
	}

//문제 4. MANAGER를 파라미터로 받고 job이 MANAGER 중 입사날짜가 가장 빠른 사원의 이름, 입사날짜, 급여 조회
//service :  입사날짜 빠른 사원 조회 (쿼리 2개필요 OR 쿼리하나로 해결 가능)
@GetMapping("/emp/job/{jobName}")

-- xml -- 
<select id="getJob" resultType="EmpVO">
select 
ename,
job,
HIREDATE,
SAL 
from emp e 
where job = #{jobName}
limit 1
</select>

-- mapper --
public EmpVO selectEmpJobAndHiredate(Stirng job);


-- service --
public EmpVO getEmpJobAndHiredate(String job){
		return empMapper.selectEmpJobAndHiredate(job);
	}

-- controller - 
@GetMapping("/emp/job/{jobName}")
	public EmpVO callEmpJobAndHiredate(@PathVariable("jobName")  String job){
		return empService.getEmpJobAndHiredate(job);
	}

//(join 문제)*문제 5. 사원번호 7782를 파라미터로 받고 해당 사원의 모든 정보(부서번호, 부서이름, 부서위치 포함) 조회
@GetMapping("/emp/empno/{empno}")

-- xml -- 
<select id="selectEmpAndDeptEmpno" resultType="EmpVO">
	SELECT
		e.EMPNO,
		e.ENAME,
		e.JOB,
		e.MGR,
		e.HIREDATE,
		e.SAL ,
		e.COMM,
		e.DEPTNO,
		d.DNAME,
		d.LOC 
	From 
		emp e join dept d on e.DEPTNO = d.DEPTNO 
		AND e.EMPNO = #{empno}
</select>


-- mapper --
public EmpVO selectEmpAndDeptEmpno(int empno);	


-- service --
public EmpVO getEmpAndDeptEmpno(int empno) {
		return empMapper.selectEmpAndDeptEmpno(empno);
	}


-- controller - 
	
	@GetMapping("/emp/dept/empno/{empno}")
	public EmpVO callEmpAndDeptEmpno(@PathVariable("empno") int empno) {
		return empService.getEmpAndDeptEmpno(empno);
	}

```





### 비즈니스
```java
//문제 2. 1987년에 입사한 사원 수가 3명 이하면 1981년에 입사한 사원으로 조회하시오.
//문제 3. 급여가 가장 높은 사원 조회
//문제 4. 입사날짜 빠른 사원 조회 (쿼리 2개필요 OR 쿼리하나로 해결 가능)
```

### 퍼시스턴스
```xml
<!-- 문제 0. 부서가 10, 30에 속하는 사원 중 급여가 1500을 넘는 사원의 이름 및 급여 조회 -->
<!-- 문제 1. MGR이 NULL인 사원 이름, 직업, 급여 조회 -->
<!-- 문제 2. 특정 년도에 입사한 사원 이름, 직업, 입사날짜, 급여 조회-->
<!-- 문제 3. 입사 날짜가12월에 입사한 사원 이름, 급여 조회-->
<!-- 문제 4. 특정 job에 속한 사원번호, 사원 이름, 입사날짜 조회 -->
<!-- 문제 5. 특정 사원의 모든 정보 조회(emp, dept 테이블 조인) -->
```