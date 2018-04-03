package model;

import java.util.Map;

import org.bson.types.ObjectId;

public class Reply {
	public ObjectId id;
	public String writer;
	public String context;
	public String like;
	public String wdate;
	public String code;
	public String nick;
	public Reply() {

	}

	public Reply(Map pop) {
		if (pop.get("writer") != null)
			this.writer = (String) pop.get("writer");
		if (pop.get("context") != null)
			this.context = (String) pop.get("context");
		if (pop.get("like") != null)
			this.like = (String) pop.get("like");
		if (pop.get("wdate") != null)
			this.wdate = (String) pop.get("wdate");
		if (pop.get("code") != null)
			this.code = (String) pop.get("code");
		if (pop.get("nick") != null)
			this.nick = (String) pop.get("nick");

	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getLike() {
		return like;
	}

	public void setLike(String like) {
		this.like = like;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "Reply [id=" + id + ", writer=" + writer + ", context=" + context + ", like=" + like + ", wdate=" + wdate
				+ ", code=" + code + ", nick=" + nick + "]";
	}

	


}
