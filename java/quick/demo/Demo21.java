package demo;

import java.lang.annotation.Annotation;

public class Demo21 {

  public static void main(String[] args) {
    // System.out.println("anno");

    Class useClass = Use21.class;
    System.out.println("classname: " + useClass.getName());

    Annotation[] annos = useClass.getAnnotations();
    System.out.println("annos length: " + annos.length);

    for(Annotation anno : annos) {
      if(anno instanceof MyAnnotation21) {
        MyAnnotation21 myAnno = (MyAnnotation21) anno;
        System.out.println("name: " + myAnno.name());
        System.out.println("age: " + myAnno.age());
        // System.out.println("newNames: " + myAnno.newNames()[0]);
      }
    }
  }
}
