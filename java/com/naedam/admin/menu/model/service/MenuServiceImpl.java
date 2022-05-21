package com.naedam.admin.menu.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.menu.model.dao.MenuDao;
import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Head;
import com.naedam.admin.menu.model.vo.Menu;
import com.naedam.admin.menu.model.vo.Meta;

@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	private MenuDao menuDao;
	
	//메뉴 등록
	@Override
	public int addMenu(Menu menu) throws Exception {
		return menuDao.addMenu(menu);
	}
	
	//헤더 등록
	@Override
	public int addHead(Head head) throws Exception {
		return menuDao.addHead(head);
	}
	
	//헤더관리 등록
	@Override
	public int addRevision(Menu menu) throws Exception {
		return menuDao.addRevision(menu);
	}
	
	//메뉴 리스트 출력
	@Override
	public Map<String, Object> getMenuList(Map<String,Object> map) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuList(map));
		
		return resultMap;
	}
	
	//조건식 메뉴 리스트 출력
	@Override
	public Map<String, Object> getMenuList2(Map<String,Object> map) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuList2(map));
		
		return resultMap;
	}	
	
	//조건식 메뉴 리스트 출력2
	@Override
	public Map<String, Object> getMenuList3(Map<String,Object> map) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuList3(map));
		
		return resultMap;
	}	
	
	//리비젼 리스트
	@Override
	public Map<String, Object> getRevisionList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getRevisionList(map));
		
		return resultMap;
	}

	//삭제된 리비젼 리스트
	@Override
	public Map<String, Object> deleteRevisionList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.deleteRevisionList(map));
		
		return resultMap;
	}
	
	//헤더관리 리스트
	@Override
	public Map<String, Object> getHeadList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getHeadList(map));
		
		return resultMap;
	}
	
	//메뉴카테고리 리스트
	@Override
	public Map<String, Object> getMenuCategoryList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuCategoryList(map));
		
		return resultMap;
	}
	
	//메뉴카테고리 리스트2
	@Override
	public Map<String, Object> getMenuCategoryList2(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuCategoryList2(map));
		
		return resultMap;
	}	
	
	//메뉴 수정
	@Override
	public int updateMenu(Menu menu) throws Exception {
		return menuDao.updateMenu(menu);
	}
	
	//헤더 수정
	@Override
	public int updateHead(Head head) throws Exception {
		return menuDao.updateHead(head);
	}
	
	//하단 수정
	@Override
	public int updateBottom(Bottom bottom) throws Exception {
		return menuDao.updateBottom(bottom);
	}
	
	//메타 수정
	@Override
	public int updateMeta(Meta meta) throws Exception {
		return menuDao.updateMeta(meta);
	}
	
	//메뉴 정보
	@Override
	public Menu getMenu(int code) throws Exception {
		return menuDao.getMenu(code);
	}
	
	//헤더 정보
	@Override
	public Head getHead(int headNo) throws Exception {
		return menuDao.getHead(headNo);
	}
	
	//하단 정보
	@Override
	public Bottom getBottom() throws Exception {
		return menuDao.getBottom();
	}
	
	//메타 정보
	@Override
	public Meta getMeta() throws Exception {
		return menuDao.getMeta();
	}
	
	//리비젼 가져오기
	@Override
	public Menu getRevision(Menu menu) throws Exception {
		return menuDao.getRevision(menu);
	}
	
	//선택삭제
	@Override
	public void updateChoiceMenu(int code) throws Exception {
		menuDao.updateChoiceMenu(code);
	}
	
	//삭제 리비전 복구
	@Override
	public void updateRevision(int code) throws Exception {
		menuDao.updateRevision(code);
	}
	
	//헤더관리 선택삭제
	@Override
	public void deleteChoiceHead(int headNo) throws Exception {
		menuDao.deleteChoiceHead(headNo);
	}

	//리비젼의 메뉴 삭제
	@Override
	public void deleteMenu(int code) throws Exception {
		menuDao.deleteMenu(code);
	}




























	
}
