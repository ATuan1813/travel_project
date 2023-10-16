package model;

public class User {
	private Long id;
	private String username;
	private String password;
	private String email;
	private String fullName;
	private String phoneNumber;
	private String address;
	private String status;
	private Long role_id;

	public User(Long id, String username, String password, String email, String fullName, String phoneNumber,
			String address, String status, Long role_id) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.email = email;
		this.fullName = fullName;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.status = status;
		this.role_id = role_id;
	}

	public User(String username, String password, String email, String fullName, String phoneNumber, String address,
			String status, Long role_id) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		this.fullName = fullName;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.status = status;
		this.role_id = role_id;
	}

	public User(String username, String password, String email, String fullName, String phoneNumber, String address,
			Long role_id) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		this.fullName = fullName;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.role_id = role_id;
	}

	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public User() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phone_number) {
		this.phoneNumber = phone_number;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String full_name) {
		this.fullName = full_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getRole_id() {
		return role_id;
	}

	public void setRole_id(Long role_id) {
		this.role_id = role_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
