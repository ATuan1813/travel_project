package service;

import javax.servlet.http.HttpServletRequest;

import model.Paging;

public class PagingService<T> {
	
	public Paging<T> getPaging(HttpServletRequest request) {
		String checkPage = request.getParameter("page");
		String checkSize = request.getParameter("size");
		Paging<T> paging = new Paging<T>();
			
		int page = 0;
		int size = 0;
		if(checkPage == null) {
			page = 1;
			paging.setPage(page);
		}else {
			page = Integer.parseInt(checkPage);
			paging.setPage(page);
		}
		if(checkSize == null) {
			size = 10;
			paging.setSize(size);

		}else {
			size = Integer.parseInt(checkSize);
			paging.setSize(size);
		}
		return paging;
	}
	
}
