package model;

import java.util.List;

public class Paging<T> {
	private Integer page;
	private Integer size;
	private int totalPage;
	private Integer totalItem;

	private List<T> data;

	public Paging(Integer page, Integer size, int totalPage, Integer totalItem, List<T> data) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.totalItem = totalItem;
		this.data = data;
	}
	

	public Paging() {
		super();
	}


	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getTotalItem() {
		return totalItem;
	}

	public void setTotalItem(Integer totalItem) {
		this.totalItem = totalItem;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

}
