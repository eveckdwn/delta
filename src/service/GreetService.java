package service;

import org.springframework.stereotype.Service;

@Service
public class GreetService {
	public String make() {
		String[] ments = "�������,WELCOME".split(",");
				
		return ments[(int)(Math.random()*ments.length)];
	}

}
