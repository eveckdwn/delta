package model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.bson.types.ObjectId;

public class Board {
	public ObjectId id;
	public String writer;
	public String title;
	public String context;
	public String readnum;
	public String like;
	public String wdate;
	public String type;
	public String tab;
	public String nick;
	public String menu;
	
	
	
	
	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public Board() {
		
	}
	
	public Board(Map param) {
		if(param.get("id") != null)
			this.id = (ObjectId) param.get("id");
		if(param.get("writer") != null)
			this.writer = (String) param.get("writer");
		if(param.get("title") != null)
			this.title = (String) param.get("title");
		if(param.get("context") != null)
			this.context = (String) param.get("context");
		if(param.get("readnum") != null)
			this.readnum = (String) param.get("readnum");
		if(param.get("like") != null)
			this.like = (String) param.get("like");
		if(param.get("wdate") != null) {
			this.wdate = (String) param.get("wdate");
		}else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			this.wdate = sdf.format(new Date());
		}
		if(param.get("type") != null)
			this.type = (String) param.get("type");
		if(param.get("tab") != null)
			this.tab = (String) param.get("tab");
		if(param.get("nick") != null)
			this.nick = (String) param.get("nick");
		if(param.get("menu") != null)
			this.menu = (String) param.get("menu");
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getReadnum() {
		return readnum;
	}

	public void setReadnum(String readnum) {
		this.readnum = readnum;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTab() {
		return tab;
	}

	public void setTab(String tab) {
		this.tab = tab;
	}

	@Override
	public String toString() {
		return "Board [id=" + id + ", writer=" + writer + ", title=" + title + ", context=" + context + ", readnum="
				+ readnum + ", like=" + like + ", wdate=" + wdate + ", type=" + type + ", tab=" + tab + ", nick=" + nick
				+ ", menu=" + menu + "]";
	}

	
	
	
}