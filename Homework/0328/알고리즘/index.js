// 자바스크립트 or 자바 선택해서 풀 것!
// 버블정렬을 이용하여 오름차순으로 정렬하고 총 몇회전 했는지 알아내시오. => 4회전
let array = [1, 10, 4, 3, 5];
let count = 0; //총 몇회전 했는지 알아내는 변수
var temp = 0;
for(var i = 0; i< array.length; i++){
    for(var j=0; j<array.length-i-1; j++){
        if(array[j] > array[j+1]){
            count = array[j];
        array[j] = array[j+1]
        array[j+1] = count;       }
    }
}

for(var i=0; i<array.length; i++){
    console.log('[%d]',array[i]);
}



console.log(array);
console.log('정렬 회전 수는 : '+ count + '입니다.');



// https://gmlwjd9405.github.io/2018/05/06/algorithm-bubble-sort.html0