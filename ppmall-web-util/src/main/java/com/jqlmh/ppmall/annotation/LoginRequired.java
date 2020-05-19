package com.jqlmh.ppmall.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author LMH
 * @create 2020-04-24 15:50
 */

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface LoginRequired {

	boolean mustLogin() default false;  //是否一定需要登录才能放行的方法


}
