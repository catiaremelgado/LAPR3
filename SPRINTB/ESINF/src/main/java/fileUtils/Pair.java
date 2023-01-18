package fileUtils;

import java.util.Comparator;

public class Pair<T extends Comparable<T>,U extends Comparable<U>>{

    private T left;
    private U right;

    public Pair(T left, U right) {
        this.left = left;
        this.right = right;
    }

    public T getLeft() {
        return left;
    }

    public void setLeft(T left) {
        this.left = left;
    }

    public U getRight() {
        return right;
    }

    public void setRight(U right) {
        this.right = right;
    }



    class LeftComparator implements Comparator<Pair<T,U>> {
        @Override
        public int compare(Pair<T,U> o1, Pair<T,U> o2) {
            return o1.getLeft().compareTo(o2.getLeft());
        }
    };


    public static class RightComparator<U extends Comparable <U>> implements Comparator<Pair<?,U> >{
        @Override
        public int compare(Pair<?,U> o1, Pair<?,U> o2) {
            return o1.getRight().compareTo(o2.getRight());
        }
    };
}
