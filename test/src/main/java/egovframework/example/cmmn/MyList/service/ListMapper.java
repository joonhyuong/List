package egovframework.example.cmmn.MyList.service;

import java.util.List;
import egovframework.example.cmmn.MyList.vo.ListVo;
import egovframework.example.cmmn.MyList.vo.Search;


//Mapper namespace 와 ID를 연결할 Interface 를 두어서 interface를 호출하는 방법.
//Mybatis 매핑XML에 기재된 SQL을 호출하기 위한 인터페이스이다.
//SQL id는 인터페이스에 정의된 메서드명과 동일하게 작성한다

public interface ListMapper{
	public List<ListVo> selectList(Search search) throws Exception;
	
	public void insertList(ListVo listVo) throws Exception;
	
	public ListVo selectDetail(int testId) throws Exception;
	
	public void updateList(ListVo listVo) throws Exception;
	
	public void deleteList(ListVo listVo) throws Exception;
	
	public int getBoardListCnt(Search search) throws Exception;
	

}
