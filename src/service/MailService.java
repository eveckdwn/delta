package service;

import java.util.HashMap;
import java.util.Map;
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

	public boolean sendMail(String email, HttpSession session) {

		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String serial = uuids[0];
		session.setAttribute("serial", serial);

		MimeMessage mail = mailsender.createMimeMessage();
		try {
			mail.setRecipient(RecipientType.TO, new InternetAddress(email));
			mail.setFrom(new InternetAddress("admin@spring.io"));
			mail.setSubject("[내일로 여행 정보 공유] 이메일 인증번호 입니다.");
			String content = "인증키를 페이지에 입력하십시오.\n이메일 인증 후 다양한 서비스를 이용하실 수 있습니다.\n";
			content += "인증키 : " + serial;
			mail.setContent(content, "text/html;charset=utf-8");

			mailsender.send(mail);
			return true;
		} catch (MessagingException me) {
			me.printStackTrace();
			return false;
		}
	}

	public boolean findPass(Map<String,String> map) {

		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String serial = uuids[0];
		
		map.put("pass", serial);
		
		String e = String.valueOf(map.get("email"));
		int cnt = template.update("users.findPass", map);
		if (cnt == 1) {
			MimeMessage mail = mailsender.createMimeMessage();
			try {
				mail.setRecipient(RecipientType.TO, new InternetAddress(e));
				mail.setFrom(new InternetAddress("admin@spring.io"));
				mail.setSubject("[내일로 여행 정보 공유] 임시 비밀번호 입니다.");
				String content = "임시 비밀번호 입니다.\n임시 비밀번호는 프로필에서 수정하실 수 있습니다.\n";
				content += "임시 비밀 번호 : " + serial;
				mail.setContent(content, "text/html;charset=utf-8");

				mailsender.send(mail);
				return true;
			} catch (MessagingException me) {
				me.printStackTrace();
				return false;
			}
		} else {
			return false;
		}
	}

	public boolean updateLv(String id) {

		return template.update("users.updateLv", id) == 1;
	}
}
