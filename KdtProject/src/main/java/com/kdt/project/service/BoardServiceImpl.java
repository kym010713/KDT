package com.kdt.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.kdt.project.dto.BoardDTO;
import com.kdt.project.entity.BoardEntity;
import com.kdt.project.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardRepository repository;
	
	

	@Override
	public int write(BoardDTO dto) {
		BoardEntity entity = new BoardEntity();
		
		entity.setWriter(dto.getBoardWriter());
		entity.setTitle(dto.getBoardTitle());
		entity.setContent(dto.getBoardContent());
		entity.setReadCount(0);
		
		BoardEntity saveEntity = repository.save(entity);
		return saveEntity.getId();
	}



	@Override
	public Page<BoardDTO> writeList(Pageable pageable) {
	    Page<BoardEntity> boardEntityList = repository.findAll(pageable);

	    List<BoardDTO> boardDTOList = new ArrayList<>();
	    for (BoardEntity entity : boardEntityList) {
	        boardDTOList.add(BoardEntity.toBoardDTO(entity));
	    }

	    return new PageImpl<>(boardDTOList, pageable, boardEntityList.getTotalElements());
	}

}
