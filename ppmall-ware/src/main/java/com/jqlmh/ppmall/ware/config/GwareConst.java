package com.jqlmh.ppmall.ware.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

/**
 * ppmall
 *
 * @author LMH
 * @date 2020/05/26
 */
@Configuration
public class GwareConst {

    @Value("${order.split.url:noValue}")
    public static String ORDER_SPLIT_URL;
}
