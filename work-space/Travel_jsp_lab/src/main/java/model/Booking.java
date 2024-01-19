package model;

import java.sql.Date;

public class Booking {
	private Long id;
	private String name;
	private Long price;
	private Long adult;
	private Long child;
	private String fullName;
	private Date createDate;
	private String dateStr;
	
	public Booking(Long id, Date createDate) {
		super();
		this.id = id;
		this.createDate = createDate;
	}
	
	
	public Booking() {
		super();
	}


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public Long getAdult() {
		return adult;
	}
	public void setAdult(Long adult) {
		this.adult = adult;
	}
	public Long getChild() {
		return child;
	}
	public void setChild(Long child) {
		this.child = child;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getDateStr() {
		return dateStr;
	}
	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
	}
}
