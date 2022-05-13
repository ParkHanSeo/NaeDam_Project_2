package com.naedam.admin.menu.model.dao;

import java.util.List;
import java.util.Map;

import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Head;
import com.naedam.admin.menu.model.vo.Menu;
import com.naedam.admin.menu.model.vo.MenuCategory;
import com.naedam.admin.menu.model.vo.Meta;

public interface MenuDao {
	
	
	//메뉴관리 등록
	public int addMenu(Menu menu) throws Exception;
	
	//리비젼 생성
	public int addRevision(Menu menu) throws Exception;
	
	//헤더 등록
	public int addHead(Head head) throws Exception;
	
	//메뉴 리스트
	public List<Menu> getMenuList(Map<String, Object> map) throws Exception;
	
	//메뉴 리스트
	public List<Menu> getMenuList2(Map<String, Object> map) throws Exception;
	
	//메뉴 리스트
	public List<Menu> getMenuList3(Map<String, Object> map) throws Exception;
	
	//리비젼 리스트
	public List<Menu> getRevisionList(Map<String, Object> map) throws Exception;
	
	//리비젼 리스트
	public List<Menu> deleteRevisionList(Map<String, Object> map) throws Exception;
	
	//헤더 리스트
	public List<Head> getHeadList(Map<String, Object> map) throws Exception;
	
	//메뉴 카테고리 리스트
	public List<Menu> getMenuCategoryList(Map<String, Object> map) throws Exception;
	
	//메뉴 카테고리 리스트2
	public List<Menu> getMenuCategoryList2(Map<String, Object> map) throws Exception;
	
	//메뉴 수정
	public int updateMenu(Menu menu) throws Exception;
	
	//헤더 수정
	public int updateHead(Head head) throws Exception;
	
	//하단 수정
	public int updateBottom(Bottom bottom) throws Exception;
	
	//메타 수정
	public int updateMeta(Meta meta) throws Exception;
	
	//메뉴 정보
	public Menu getMenu(int code) throws Exception;
	
	//리비젼 가져오기
	public Menu getRevision(Menu menu) throws Exception;
	
	//헤더 정보
	public Head getHead(int headNo) throws Exception;
	
	//하단 정보
	public Bottom getBottom() throws Exception;
	
	//메타 정보
	public Meta getMeta() throws Exception;
	
	//삭제리비전 복구
	public void updateRevision(int code) throws Exception;
	
	//메뉴 선택삭제
	public void updateChoiceMenu(int code) throws Exception;
	
	//헤더 선택삭제
	public void deleteChoiceHead(int headNo) throws Exception;
	
	//리비젼의 메뉴 삭제
	public void deleteMenu(int code) throws Exception;
	

}
