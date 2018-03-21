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
			// ������ ��� - google �������� ���� �� ������ ������.
			mail.setFrom(new InternetAddress("admin@spring.io"));
			// ����
			mail.setSubject("[���Ϸ� ���� ��������] ������ ���ϵ帳�ϴ�");
			// ����
			String content = "�̸��� ������ ��û�ϼ̽��ϴ�.\n����Ű�� �������� �Է��Ͽ� �ּ���.\n";
			content += "����Ű : " + serial;
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
