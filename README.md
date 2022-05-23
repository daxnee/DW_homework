# Html study :headphones:
It's called woodangtangtang study :wink:





		 int max = 0 ;
		 EmpVO vo = null;
		 List<EmpVO> list = empMapper.selectEmpMax(hiredate);
		 for(int i=0; i<list.size(); i++) {
			 if(max < list.get(i).getSal()) {
				 max = list.get(i).getSal();
				 if(max == list.get(i).getSal()) {
					 vo = list.get(i);
				 }
			 }
		 }
		 List<EmpVO> maxSalList = new ArrayList<EmpVO>();
		 maxSalList.add(vo);