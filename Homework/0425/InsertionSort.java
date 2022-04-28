package 삽입정렬;

public class InsertionSort {
	
		public static void main(String[] args) {
		int array[] = {8, 5, 6, 2, 4};
		int temp = 0;
		int len = array.length;
		 //삽입정렬을 이용하여 오름차순 정렬!
		for(int i=1; i<len; i++) {
			int key = array[i];
			for(int j=i-1; j>=0 && array[j]<array[i]; j--) {
				if(key > array[j]) {
					// -------------
					array[j+1] = array[j];// temp == array[1]
					array[j+1] = key;
					}
				System.out.println(array[j]);
			 	}
			}
}
}