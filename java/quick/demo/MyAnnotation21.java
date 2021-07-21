package demo;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
@interface MyAnnotation21 {
	String value();
	String name();
	int age() default 10;
	String[] newNames();
}
