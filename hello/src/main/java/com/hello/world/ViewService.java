package com.hello.world;

import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.hello.world.dao.BbsDao;
import com.hello.world.dao.BbsVo;
import com.hello.world.dao.ProveDao;
import com.hello.world.dao.ProveVo;

@Service
public class ViewService {
	
    @Resource(name = "bbsDao")
    private BbsDao bbsDao;
    
    @Resource(name = "proveDao")
    private ProveDao proveDao;

	public int txSaveBbs(BbsVo bbsVo, HttpServletRequest request){
		
		this.bbsDao.insert(bbsVo);
	    int idx = bbsVo.getIdx();
	        
	        
		Enumeration<String> en = request.getParameterNames();
        
        ProveVo proveVo = new ProveVo();
        proveVo.setIdx(idx);
        while(en.hasMoreElements()){
        	String nm = en.nextElement();
        	if(nm.indexOf("prove_seq")>-1){
        		String prove_seq = request.getParameter(nm);
        		String num = nm.replaceAll("prove_seq", "");
        		proveVo.setSeq(Integer.parseInt(prove_seq));
        		proveVo.setNum(Integer.parseInt(num));
        		proveDao.updateIdx(proveVo);
        	}
        }
        
        return idx;
	}
    
}
