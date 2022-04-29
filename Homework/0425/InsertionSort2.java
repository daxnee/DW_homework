package 정렬;

public class InsertionSort {
	public void insertion(int[] array) {
	     int len = array.length;
	     int j=0;
	      //삽입정렬을 이용하여 오름차순 정렬!
	     for(int i=1; i<len; i++) {
	        int temp = array[i];
	        for(j=i-1; j>=0 && temp<array[j]; j--) {
	           array[j+1] = array[j];
	            }  
	        array[j+1] = temp;
	        }
	  }
	 
	  public static void main(String[] args) {
	     InsertionSort ins = new InsertionSort();
	     int array[] = {8, 5, 6, 2, 4};
	     ins.insertion(array);
	     for(int i=0; i<array.length; i++) {
	        System.out.println(array[i]);
	     }
	     }

}
