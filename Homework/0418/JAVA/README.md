1. user 패키지 생성

2. UserVO 클래스 생성 (main 함수 x)
```java
    //VO는 Value Objec의 약자.
    //Value Object에는 필드변수,생성자,getter,setter만 존재함.
    public class UserVO{
        private String ename; //직원 이름
        private String dname; //부서 이름
        private int sal;  //급여
        private int lv; //직원 레벨
        
        public UserVO(String ename, String dname, int sal){
            this.ename = ename;
            this.dname = dname;
            this.sal = sal;
        }
        //0. getter,setter 함수를 생성하시오. 
        public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public int getSal() {
		return sal;
	}

	public void setSal(int sal) {
		this.sal = sal;
	}

	public int getLv() {
		return lv; 
	}

	public void setLv(int lv) {
		this.lv = lv;
	}
    }
```

3. UserService 클래스 생성 (main 함수 x)
```java
    public class UserService implements UserServiceImple{ // 샹속

        //1. 부서이름이 DEVELOP인 사원 급여를 2배 인상하시오.
        @Override
        public List<UserVO> updateSal(List<UserVO> list, String dname){
            //list안에 UserVO라는 클래스가 또 들어있음
		// 그러나 UserVO 안에 필드변수가 private이다. => 직접 가져오지 못하니까 get set을 이용해서 가져옴
            for(int i=0; i<list.size(); i++) {
			String temp =list.get(i).getDname(); // list의 0번째 배열 안 get을 가져온 것임
			if(temp.equals(dname)) {
				int sal = list.get(i).getSal();
				sal *= 2;
				list.get(i).setSal(sal); // set을 이용해서 수정된 급여를 넣어준다.
			}
			System.out.println();
		}
            return list;
        }
        //2. 급여가 0 ~ 100 : 1 레벨, 101 ~ 1000 : 2 레벨, 1001 이상부터는 3 레벨로 수정하시오.
        @Override
        public List<UserVO> updateLv(List<UserVO> list){
            for(int i=0; i<list.size(); i++) {
			int sal = list.get(i).getSal();
			if(sal > 0 && sal <= 100) {
				list.get(i).setLv(1);
			}
			if(sal >= 101 && sal <= 1000) {
				list.get(i).setLv(2);
			}
			
			if(sal >= 1001) {
				list.get(i).setLv(3);
			}
		}
            return list;
        }
        //3. 레벨 3이상 직원을 모두 해고하시오.
        @Override
        public List<UserVO> deleteUser(List<UserVO> list, int lv){
            for(int i=0; i<list.size(); i++) {
		int tempLv = list.get(i).getLv();
		if(tempLv >= lv) {
			list.remove(i);
			}
		}
            return list;
        }
        //4. 이름이 King인 직원의 모든 정보 조회.
        @Override
        // 리턴타입이 list가 아니라 클래스임
        public UserVO selectUserByEname(List<UserVO> list, String ename){
            for(int i=0; i<list.size(); i++) {
			String tempEname = list.get(i).getEname();
			if(ename.equals(tempEname)) {
				return list.get(i);
			}
		}
            return null; // 리턴 타입이 클래스라서 null이 가능.
        }
    }
```

4. MainController 클래스 생성 (main 함수 o)
```java
    public class MainController{
        public static void main(String args[]){
            
            List<UserVO> list = new ArrayList<UserVO>();
            list.add(new UserVO("Alex","DEVELOP",200));
            list.add(new UserVO("Max","DEVELOP",80));
            list.add(new UserVO("Brian","DEVELOP",100));
            list.add(new UserVO("mr.Hyun","MANAGER",300));
            list.add(new UserVO("Allen","DEVELOP",110));
            list.add(new UserVO("Katter","DEVELOP",220));
            list.add(new UserVO("Hooker","MANAGER",1500));
            list.add(new UserVO("King","MASTER",0));

            //여기서 문제 풀 것
        UserServiceImple service = new UserService(); //  UserServiceImple(부모)  UserService(자식)
        //   부모는 자식을 포함할 수 있어서 이렇게 구현이 가능함 (마치 int를 String으로 변환하는 구조와 비슷함)
        //1번
        list = service.updateSal(list,"DEVELOP");
        printList(list);
        //2번
        list = service.updateLv(list);
        printList(list);
        //3번
        list = service.deleteUser(list, 3);
        printList(list);
        //4번
        UserVO vo = service.selectUserByEname(list, "King");
        System.out.println("사원 이름 : "+vo.getEname()+", 부서 이름 : "+vo.getDname()+", 직원 급여 : "+vo.getSal()+", 직원 레벨 : "+vo.getLv());
	}
	//결과를 확인하는 메소드
	public static void printList(List<UserVO> list){
		System.out.println("====================================================================");
		for(UserVO vo : list){
			System.out.println("사원 이름 : "+vo.getEname()+", 부서 이름 : "+vo.getDname()+", 직원 급여 : "+vo.getSal()+", 직원 레벨 : "+vo.getLv());
		}
		System.out.println("====================================================================");
      
        }
    }
```








***     printList(list);
    @Override 해당 클래스 이름 누르면 add뜨는데 왜 나는 안뜨지

