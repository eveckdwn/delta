package service;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	@Autowired
	JavaMailSender mailsender;
	
	@Autowired
	SqlSessionTemplate template;

	public boolean sendMail(String email,HttpSession session) {
		
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String serial = uuids[0];
		session.setAttribute("serial", serial);
		
		MimeMessage mail = mailsender.createMimeMessage();
		try {
			mail.setRecipient(RecipientType.TO, new InternetAddress(email));
			// 보내는 사람 - google 서버같은 경우는 이 설정을 무시함.
			mail.setFrom(new InternetAddress("admin@spring.io"));
			// 제목
			mail.setSubject("[내일로 여행 정보공유] 가입을 축하드립니다");
			// 내용
			String content = "이메일 인증을 요청하셨습니다.\n인증키를 페이지에 입력하여 주세요.\n";
			content += "인증키 : " + serial;
			mail.setContent(content, "text/html;charset=utf-8");

			mailsender.send(mail);
			return true;
		} catch (MessagingException me) {
			me.printStackTrace();
			return false;
		}
	}
	
	public boolean updateLv(String id) {
		
		return template.update("users.updateLv",id)==1;
	}
}
