package com.hello.world.dao;

import java.util.List;
import org.springframework.stereotype.Repository;

@Repository(value = "proveMapper")
public interface ProveMapper {
    List<ProveVo> select();

    ProveVo selectOne(int idx);
    ProveVo selectOneByNum(ProveVo proveVo);
    void insert(ProveVo proveVo);
    void update(ProveVo proveVo);
    void updateIdx(ProveVo proveVo);
    void delete(int idx);
}
