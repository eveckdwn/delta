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
	public int readnum;
	public int like;
	public Date wdate;
	public int type;
	public String tab;

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
		this.readnum = 0;
		this.like = 0;
		this.wdate = new Date();
		if(param.get("type") != null)
			this.type = (int) param.get("type");
		if(param.get("tab") != null)
			this.tab = (String) param.get("tab");
	}
	
	public Board(ObjectId id, String writer, String title, String context, int readnum, int like, Date wdate, int type,
			String tab) {
		this.id = id;
		this.writer = writer;
		this.title = title;
		this.context = context;
		this.readnum = readnum;
		this.like = like;
		this.wdate = wdate;
		this.type = type;
		this.tab = tab;
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

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public Date getWdate() {
		return wdate;
	}

	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
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
				+ readnum + ", like=" + like + ", wdate=" + wdate + ", type=" + type + ", tab=" + tab + "]";
	}
	
}