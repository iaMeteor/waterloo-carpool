package com.example.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import org.springframework.roo.addon.json.RooJson;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
@RooJson
public class Post {

    /**
     */
    @NotNull
    private String origin;

    /**
     */
    @NotNull
    private String destination;

    /**
     */
    @NotNull
    private String date_time;

    /**
     */
    private Float price;

    /**
     */
    @NotNull
    private String tel;

    /**
     */
    private String name;

    /**
     */
    private Boolean off_LF;
}
