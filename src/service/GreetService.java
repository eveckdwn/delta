package service;

import org.springframework.stereotype.Service;

@Service
public class GreetService {
	public String make() {
		String[] ments = "어서오세요,WELCOME".split(",");
				
		return ments[(int)(Math.random()*ments.length)];
	}

}
