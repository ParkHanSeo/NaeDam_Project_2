package com.naedam.admin.menu.model.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Head;
import com.naedam.admin.menu.model.vo.Menu;
import com.naedam.admin.menu.model.vo.MenuCategory;
import com.naedam.admin.menu.model.vo.Meta;


@Repository
public class MenuDaoImpl implements MenuDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//메뉴관리 등록
	@Override
	public int addMenu(Menu menu) throws Exception {
		return sqlSession.insert("menu.addMenu", menu);
	}
	
	//헤더관리 등록
	@Override
	public int addHead(Head head) throws Exception {
		return sqlSession.insert("menu.addHead", head);
	}
	
	//리비젼 생성
	@Override
	public int addRevision(Menu menu) throws Exception {
		return sqlSession.insert("menu.addRevision", menu);
	}
	
	//메뉴 리스트 출력
	@Override
	public List<Menu> getMenuList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getMenuList");
	}
	
	//조건식 메뉴 리스트 출력
	@Override
	public List<Menu> getMenuList2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getMenuList2", map);
	}	
	
	//조건식 메뉴 리스트 출력2
	@Override
	public List<Menu> getMenuList3(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getMenuList3", map);
	}	
	
	//리비젼 리스트
	@Override
	public List<Menu> getRevisionList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getRevisionList", map);
	}
	
	//삭제된 리비젼 리스트
	@Override
	public List<Menu> deleteRevisionList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.deleteRevisionList", map);
	}
	
	//헤더 리스트
	@Override
	public List<Head> getHeadList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getHeadList", map);
	}
	
	//메뉴 카테고리 리스트
	@Override
	public List<Menu> getMenuCategoryList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getMenuCategoryList", map);
	}
	
	//메뉴 카테고리 리스트2
	@Override
	public List<Menu> getMenuCategoryList2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("menu.getMenuCategoryList2", map);
	}
	
	//메뉴 수정
	@Override
	public int updateMenu(Menu menu) throws Exception {
		return sqlSession.update("menu.updateMenu", menu);
	}
	
	//헤더 수정
	@Override
	public int updateHead(Head head) throws Exception {
		return sqlSession.update("menu.updateHead", head);
	}
	
	//하단 수정
	@Override
	public int updateBottom(Bottom bottom) throws Exception {
		return sqlSession.update("menu.updateBottom", bottom);
	}
	
	//메타 수정
	@Override
	public int updateMeta(Meta meta) throws Exception {
		return sqlSession.update("menu.updateMeta", meta);
	}
	
	//메뉴 정보
	@Override
	public Menu getMenu(int code) throws Exception {
		return sqlSession.selectOne("menu.getMenu", code);
	}
	
	//헤더 정보
	@Override
	public Head getHead(int headNo) throws Exception {
		return sqlSession.selectOne("menu.getHead", headNo);
	}
	
	//하단 정보
	@Override
	public Bottom getBottom() throws Exception {
		return sqlSession.selectOne("menu.getBottom");
	}

	//메타 정보
	@Override
	public Meta getMeta() throws Exception {
		return sqlSession.selectOne("menu.getMeta");
	}
	
	//리비젼 가져오기
	@Override
	public Menu getRevision(Menu menu) throws Exception {
		return sqlSession.selectOne("menu.getRevision", menu);
	}
	
	//메뉴 선택 삭제 후 리비젼
	@Override
	public void updateChoiceMenu(List<Integer> code) throws Exception {
		sqlSession.update("menu.updateChoiceMenu", code);
	}
	
	//삭제 리비전 복구
	@Override
	public void updateRevision(int code) throws Exception {
		sqlSession.update("menu.updateRevision", code);
	}
	
	//헤더관리 선택삭제
	@Override
	public void deleteChoiceHead(List<Integer> headNo) throws Exception {
		sqlSession.delete("menu.deleteChoiceHead", headNo);
	}

	//리비젼의 메뉴 삭제
	@Override
	public void deleteMenu(int code) throws Exception {
		sqlSession.delete("menu.deleteMenu", code);
	}

	//메뉴 down순서변경
	public void updateDownAsc(Map<String, Object> map) throws Exception {
		sqlSession.update("menu.updateDownAsc", map);
	}

	//메뉴 up순서변경
	public void updateUpAsc(Map<String, Object> map) throws Exception {
		sqlSession.update("menu.updateUpAsc", map);
	}
	
	//헤드 down순서변경
	public void updateHeadDownAsc(Map<String, Object> map) throws Exception {
		sqlSession.update("menu.updateHeadDownAsc", map);
	}

	//헤드 up순서변경
	public void updateHeadUpAsc(Map<String, Object> map) throws Exception {
		sqlSession.update("menu.updateHeadUpAsc", map);
	}	


}









