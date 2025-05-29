package com.kdt.project.board.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.kdt.project.board.dto.BoardDTO;
import com.kdt.project.board.entity.BoardEntity;
import com.kdt.project.board.repository.BoardRepository;

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


	@Override
	public BoardDTO writeDetail(int id) {
		Optional<BoardEntity> OptionaleEntity = repository.findById(id);
		BoardDTO dto = new BoardDTO();
		
		if(OptionaleEntity.isPresent()) {
			BoardEntity entity = OptionaleEntity.get();
			dto = BoardEntity.toBoardDTO(entity);
			
		}
		return dto;
		
	}


	@Override
	public void readCountUpdate(int id) {
		Optional<BoardEntity> OptionalEntity =  repository.findById(id);
		
		if(OptionalEntity.isPresent()) {
			BoardEntity entity = OptionalEntity.get();
			entity.setReadCount(entity.getReadCount() + 1);
			repository.save(entity);
			
		}
	}


	@Override
	public BoardDTO boardUpdate(int id) {
		Optional<BoardEntity> OptionalEntity = repository.findById(id);
		
		BoardDTO dto = null;
		if(OptionalEntity.isPresent()) {
			BoardEntity entity = OptionalEntity.get();
			dto = BoardEntity.toBoardDTO(entity);
		}
		return dto;
		
	}


	@Override
	public int boardUpdatePro(BoardDTO dto) {
	    int result = 0;

	    Optional<BoardEntity> optionalEntity = repository.findById(dto.getBoardId());

	    if (optionalEntity.isPresent()) {
	        BoardEntity entity = optionalEntity.get();

	        if (dto.getBoardWriter() != null && !dto.getBoardWriter().trim().isEmpty()) {
	            entity.setWriter(dto.getBoardWriter());
	        }

	        if (dto.getBoardTitle() != null && !dto.getBoardTitle().trim().isEmpty()) {
	            entity.setTitle(dto.getBoardTitle());
	        }

	        if (dto.getBoardContent() != null && !dto.getBoardContent().trim().isEmpty()) {
	            entity.setContent(dto.getBoardContent());
	        }
	        entity.setUpdatedAt(LocalDateTime.now());
	        
	        repository.save(entity);
	        result = 1;
	        
	    }
	    return result;
	    
	}


	@Override
	public void delete(int id) {
		repository.deleteById(id);
		
	}





}
