package com.hello.world.dao;

public class BbsVo {
	private Integer idx;
	private String user_name;
	private String subject;
	private String content;
	private String reg_datetime;
	private Integer relation_idx;
	private String opinion;
	private String type_cd;

    public Integer getIdx() {
        return idx;
    }
    public void setIdx(Integer idx) {
        this.idx = idx;
    }
    public String getUser_name() {
        return user_name;
    }
    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getReg_datetime() {
        return reg_datetime;
    }
    public void setReg_datetime(String reg_datetime) {
        this.reg_datetime = reg_datetime;
    }
	public Integer getRelation_idx() {
		return relation_idx;
	}
	public void setRelation_idx(Integer relation_idx) {
		this.relation_idx = relation_idx;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	public String getType_cd() {
		return type_cd;
	}
	public void setType_cd(String type_cd) {
		this.type_cd = type_cd;
	}
    
}
