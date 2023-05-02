package com.kh.bMember.model.vo;

import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailTest {
	
	  public String getCode() {
		  
		  StringBuffer temp = new StringBuffer();
		  Random rnd = new Random();
		  
		  for(int i = 0; i<10; i++) {
			  int rIndex = rnd.nextInt(3);
			  switch(rIndex) {
			  case 0 : temp.append((char)((int)(rnd.nextInt(26))+97));
			  break;
			  case 1 : temp.append((char)((int)(rnd.nextInt(26))+65));
			  break;
			  case 2:  temp.append((rnd.nextInt(10)));
			  break;
			  }
		  }
		  String code = temp.toString();
		  System.out.println(code);
		  
		  return code;
	  }
	
	
	
	
	 public void sendMail(String recipient,String subject,String content, String code) throws MessagingException {
	        Properties p = System.getProperties();
	        p.put("mail.smtp.starttls.enable", "true");
	        p.put("mail.smtp.host", "smtp.naver.com");
	        p.put("mail.smtp.auth", "true");
	        p.put("mail.smtp.port", "587");
	        
	 
	        Authenticator auth = new MyAuthentication();
	        Session session = Session.getDefaultInstance(p, auth);
	        MimeMessage msg = new MimeMessage(session);
	 
	        try {
	            msg.setSentDate(new Date());
	            InternetAddress from = new InternetAddress();
	            
	            from = new InternetAddress("브레이크타임<hjs5235@naver.com>");
	            msg.setFrom(from);
	 
	            InternetAddress to = new InternetAddress(recipient);
	            msg.setRecipient(Message.RecipientType.TO,to);
	 
	            msg.setSubject(subject, "UTF-8");
	            msg.setText(content+" 인증번호 : "+code, "UTF-8");
	            msg.setHeader("학생 인증", "text/html");
	 
	            javax.mail.Transport.send(msg);
	        } catch (AddressException addr_e){
	            addr_e.printStackTrace();
	        } catch (MessagingException msg_e){
	            msg_e.printStackTrace();
	        }
	    }
	}

	class MyAuthentication extends Authenticator {
	 
	    PasswordAuthentication account;
	 
	    public MyAuthentication(){
	        String id = "hjs5235";
	        String pw = "dlatlqlqjs!";
	        account = new PasswordAuthentication(id, pw);
	    }
	 
	    public PasswordAuthentication getPasswordAuthentication(){
	        return account;
	    }
}
