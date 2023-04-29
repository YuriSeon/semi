package com.kh.bMember.model.vo;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailTest {
	 public void sendMail(String recipient,String subject,String content) throws MessagingException {
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
	            
	            from = new InternetAddress("sender<hjs5235@naver.com>");
	            msg.setFrom(from);
	 
	            InternetAddress to = new InternetAddress("hjs5235@naver.com");
	            msg.setRecipient(Message.RecipientType.TO,to);
	 
	            msg.setSubject("브레이크 타임 학생 인증 메일입니다.", "UTF-8");
	            msg.setText("학생 인증 확인 메일입니다.", "UTF-8");
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
