package com.ipc.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ViewUtils {

	/*
	 * params : 
	 * 		int currentPage		: 현재 페이지 
	 * 		int totalContents	: 페이지네이션 하려는 요소의 전체 수
	 * 		int pagePerContents : 페이지별 나타고자 하는 목록 수
	 * 		int pagePerbuttons	: 페이지네이션 버튼이 몇개 까지 나오게 하고싶은지
	 *
	 * return : 
	 * 		List<Integer> 			pageButtons	: 페이지네이션 버튼 값 리스트
	 * 		HashMap<String,Integer> arrows		: 페이지네이션 버튼 양 옆 화살표의 값 맵
	 * 		HashMap<String,Integer> bounds 		: Dao에서 사용할 시작~끝 범위 
	 * 
	 * 페이지네이션 버튼 : 
	 * 		< 1 2 3 4 5 >
	 * 		< 1 2 >
	 * 
	 * 		여기서 숫자가 pageButtons
	 * 		< >가 arrows
	 */
	public HashMap<String,Object> getPageNationAttributes(int currentPage, int totalContents, int pagePerContents, int pagePerbuttons) throws Exception
	{
		HashMap<String,Object> retValue = new HashMap<String,Object>();

		//총 페이지 구하기 
		int totalPages=1;
		if (totalContents % pagePerContents == 0) 	totalPages = totalContents / pagePerContents;
		else totalPages = totalContents / pagePerContents + 1;
		
		// TODO : 범위와 관련된 예외로 변경해야함 
		if (currentPage > totalPages || currentPage <= 0) throw new Exception();
		
		//시작 글 위치 계산
		int start;
		if (totalPages == 1)
			start = 0;
		else if (currentPage == totalPages)
			start = totalContents - 10; // 마지막 페이지인 경우
		else
			start = (currentPage - 1) * 10;
		
		/*
		 * 페이지네이션 버튼 값 들
		 * if:
		 * 		총 페이지가 5개 안되면 : < 1 2 >
		 * 		총 페이지가 충분하면 	: < 3 4 5 6 7 >
		 */
		List<Integer> pageButtons = new ArrayList();
		if (totalPages < 5) 
		{
			for (int i = 1; i <= totalPages; i++)
				pageButtons.add(i);
		} 
		else 
		{
			for (int i = currentPage; i <= currentPage && i <= totalPages; i++)
				pageButtons.add(i);
		}
		retValue.put("pageButtons", pageButtons);
		
		/*
		 * 페이지네이션 버튼 양옆에 들어갈 방향표의 값 들
		 */
		HashMap<String,Integer> arrows = new HashMap<String,Integer>();
		int leftArrow = (currentPage - pagePerbuttons) < 0 ? 1 : (currentPage - pagePerbuttons);
		int rightArrow = (currentPage + pagePerbuttons) >= totalPages ? totalPages : currentPage + pagePerbuttons;
		arrows.put("leftArrow", leftArrow);
		arrows.put("rightArrow", rightArrow);
		retValue.put("arrows", arrows);
		
		/*
		 * DAO를 통해 contentList를 받기위한 Map 객체 생성 
		 */
		HashMap<String, Integer> bounds = new HashMap<String, Integer>();
		bounds.put("start", start);
		bounds.put("pagePerContents", pagePerContents);
		retValue.put("bounds", bounds);
		
		return retValue;
	}
	
}