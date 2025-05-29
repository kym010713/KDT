package com.kdt.project.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.kdt.project.dto.BoardDTO;


@Service
public interface BoardService {
	public int write(BoardDTO dto);
	public Page<BoardDTO> writeList(Pageable pageable);

}
