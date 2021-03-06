## 삽입 정렬(Insertion Sort)
    Insertion Sort는 Selection Sort와 유사하지만, 좀 더 효율적인 정렬 알고리즘.
    매 순서마다 해당 원소를 삽입할 수 있는 위치를 찾아 해당 위치에 넣는다.
    


### 삽입 정렬(insertion sort) 과정

![insertion-sort](https://user-images.githubusercontent.com/96815399/165678955-2a1a55c4-fed0-4cff-97c5-37451ce59713.png)


- 1회전: 두 번째 자료인 5를 Key로 해서 그 이전의 자료들과 비교한다.  
    Key 값 5와 첫 번째 자료인 8을 비교한다. 8이 5보다 크므로 8을 5자리에 넣고 Key 값 5를 8의 자리인 첫 번째에 기억시킨다.  
- 2회전: 세 번째 자료인 6을 Key 값으로 해서 그 이전의 자료들과 비교한다.  
    Key 값 6과 두 번째 자료인 8을 비교한다. 8이 Key 값보다 크므로 8을 6이 있던 세 번째 자리에 기억시킨다.  
    Key 값 6과 첫 번째 자료인 5를 비교한다. 5가 Key 값보다 작으므로 Key 값 6을 두 번째 자리에 기억시킨다.  
- 3회전: 네 번째 자료인 2를 Key 값으로 해서 그 이전의 자료들과 비교한다.  
    Key 값 2와 세 번째 자료인 8을 비교한다. 8이 Key 값보다 크므로 8을 2가 있던 네 번째 자리에 기억시킨다.  
    Key 값 2와 두 번째 자료인 6을 비교한다. 6이 Key 값보다 크므로 6을 세 번째 자리에 기억시킨다.  
    Key 값 2와 첫 번째 자료인 5를 비교한다. 5가 Key 값보다 크므로 5를 두 번째 자리에 넣고 그 자리에 Key 값 2를 기억시킨다.  
- 4회전: 다섯 번째 자료인 4를 Key 값으로 해서 그 이전의 자료들과 비교한다.  
    Key 값 4와 네 번째 자료인 8을 비교한다. 8이 Key 값보다 크므로 8을 다섯 번째 자리에 기억시킨다.  
    Key 값 4와 세 번째 자료인 6을 비교한다. 6이 Key 값보다 크므로 6을 네 번째 자리에 기억시킨다.  
    Key 값 4와 두 번째 자료인 5를 비교한다. 5가 Key 값보다 크므로 5를 세 번째 자리에 기억시킨다.  
    Key 값 4와 첫 번째 자료인 2를 비교한다. 2가 Key 값보다 작으므로 4를 두 번째 자리에 기억시킨다.  


### 삽입 정렬(insertion sort) 알고리즘의 특징
+ 장점
    - 안정한 정렬 방법
    - 레코드의 수가 적을 경우 알고리즘 자체가 매우 간단하므로 다른 복잡한 정렬 방법보다 유리할 수 있다.
    - 대부분위 레코드가 이미 정렬되어 있는 경우에 매우 효율적일 수 있다.

+ 단점
    - 비교적 많은 레코드들의 이동을 포함한다.
    - 레코드 수가 많고 레코드 크기가 클 경우에 적합하지 않다.