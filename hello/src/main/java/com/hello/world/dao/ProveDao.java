package com.hello.world.dao;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service(value = "proveDao")
public class ProveDao {
    @Resource(name = "proveMapper")
    private ProveMapper proveMapper;

    public List<ProveVo> getSelect() {
        return this.proveMapper.select();
    }

    public ProveVo getSelectOne(int idx) {
        return this.proveMapper.selectOne(idx);
    }

    public void insert(ProveVo proveVo) {
         this.proveMapper.insert(proveVo);
    }

    public void update(ProveVo proveVo) {
         this.proveMapper.update(proveVo);
    }

    public void delete(int idx) {
         this.proveMapper.delete(idx);
    }
}