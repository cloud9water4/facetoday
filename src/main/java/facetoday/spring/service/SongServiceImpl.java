package facetoday.spring.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.web.bind.annotation.RequestParam;

import facetoday.spring.web.dao.SongDao;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.SongListVo;
import facetoday.spring.web.vo.SongVo;

public class SongServiceImpl implements SongService {
	
	@Resource(name = "songDao")
	private SongDao songDao;

	@Override
	public List<SongVo> selectAll() throws SQLException {
		// TODO Auto-generated method stub
		List<SongVo> list = songDao.selectAll();
		
		if (list.isEmpty()) {
			//반드시 노래 목록이 존재한다는 가정..
			throw new SQLException("DB 접속 오류");
		}
		
		return list;
	}

	@Override
	public String checkSong(@RequestParam("check") String check) {
		
		return check;
	}
	@Override
	public List NaverList() throws IOException{
		Document doc = Jsoup.connect("http://music.naver.com/listen/top100.nhn?domain=TOTAL&duration=1h").get();
		//Elements titles = doc.select(".roadname");
		Elements titles = doc.select(".ellipsis");
		int i = 0; 
		//print all titles in main page
		List naverList=null;
		naverList=new ArrayList();
		String str1 = null;
		String str2;
		for(Element e: titles){
			if(i %2== 0){
				str1=e.text();
			}
			else
			{
			str2=e.text();
			naverList.add(str1  +" - "+  str2);	
			}    
		
			i++;
		}
		System.out.println(naverList);
	return naverList;
	}

	@Override
	public boolean createList(SongListVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return songDao.createList(vo);
	}

	@Override
	public boolean userList(SongListVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return songDao.userList(vo);
	}

	@Override
	public List<SongListVo> userlistAll(MemberVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return songDao.userlistAll(vo);
	}
}
