package model;

import java.util.Arrays;
import java.util.Map;
import org.bson.types.ObjectId;

public class Hero {
	public ObjectId id;
	public String name;
	public String role;
	public String[] skill;
	public int star;

	public Hero() {
		
	}
	
	public Hero(String name, String role, String[] skill, int star) {
		if (name != null)
			this.name = name;
		if (role != null)
			this.role = role;
		if (skill != null)
			this.skill = skill;
		if (Integer.valueOf(star) != null)
			this.star = star;
	}
	
	public Hero(Map param) {
		if(param.get("name") != null) 
			this.name = (String)param.get("name");
		if(param.get("role") != null) 
			this.role = (String)param.get("role");
		if(param.get("skill") != null) 
			this.skill = (String[])param.get("skill");
		if(param.get("star") != null) 
			this.star = (int)param.get("star");
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String[] getSkill() {
		return skill;
	}

	public void setSkill(String[] skill) {
		this.skill = skill;
	}

	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	@Override
	public String toString() {
		return "Hero [id=" + id + ", name=" + name + ", role=" + role + ", skill=" + Arrays.toString(skill) + ", star="
				+ star + "]";
	}

}
