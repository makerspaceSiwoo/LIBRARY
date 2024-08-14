package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UserDto {

   private int userno;
   private String admin;
   private String userID;
   private String userPW;
   private String gender;
   private String name;
   private Date birth;
   private String phone;
   private String email;
   private String address;
   private Date ban;
   private int penalty;
   private String state;
   
}