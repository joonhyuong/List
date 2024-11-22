package egovframework.example.cmmn.MyList.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.cmmn.MyList.dao.ListDao;
import egovframework.example.cmmn.MyList.service.ListMapper;
import egovframework.example.cmmn.MyList.vo.Search;
import egovframework.example.cmmn.MyList.vo.ListVo;

@Repository
public class ListDaoImpl implements ListDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ListVo> selectList(Search search) throws Exception {
		ListMapper mapper = sqlSession.getMapper(ListMapper.class);
		return mapper.selectList(search);
	}
	
	@Override
	public void insertList(ListVo listVo) throws Exception {
		ListMapper mapper = sqlSession.getMapper(ListMapper.class);
		mapper.insertList(listVo);
	}
	
	@Override
	public ListVo selectDetail(int testId) throws Exception {
		ListMapper mapper = sqlSession.getMapper(ListMapper.class);
		return mapper.selectDetail(testId);
	}
	
	@Override
	public void updateList(ListVo listVo) throws Exception {
		ListMapper mapper = sqlSession.getMapper(ListMapper.class);
		mapper.updateList(listVo);
	}
	
	@Override
	public void deleteList(ListVo listVo) throws Exception {
		ListMapper mapper = sqlSession.getMapper(ListMapper.class);
		mapper.deleteList(listVo);
	}
	
	@Override
	public int getBoardListCnt(Search search) throws Exception {
		ListMapper mapper = sqlSession.getMapper(ListMapper.class);
		return mapper.getBoardListCnt(search);
	}

}
