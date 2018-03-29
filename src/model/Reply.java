package model;

import java.util.Map;

import org.bson.types.ObjectId;

public class Reply {
	public ObjectId id;
	public String writer;
	public String context;
	public String like;
	public String wdate;

	public Reply(Map param) {
		if(param.get("id") != null)
			this.id = (ObjectId) param.get("id");
		if(param.get("writer") != null)
			this.writer = (String) param.get("writer");
		if(param.get("context") != null)
			this.context = (String) param.get("context");
		if(param.get("like") != null)
			this.like = (String) param.get("like");
		if(param.get("wdate") != null)
			this.wdate = (String) param.get("wdate");
		
	}
	
	
	

	public Object getId() {
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
	
	@Override
	public String toString() {
		return "Reply [id=" + id + ", writer=" + writer + ", context" + context + ", like="
				+ like + ", wdate" + wdate + "]";
	}
	
	
	
}

