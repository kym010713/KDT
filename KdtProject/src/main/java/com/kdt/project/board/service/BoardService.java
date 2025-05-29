package com.kdt.project.board.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.kdt.project.board.dto.BoardDTO;


@Service
public interface BoardService {
	public int write(BoardDTO dto);
	public Page<BoardDTO> writeList(Pageable pageable);
	public BoardDTO writeDetail(int id);
	public void readCountUpdate(int id);
	public BoardDTO boardUpdate(int id);
	public int boardUpdatePro(BoardDTO dto);
	public void delete(int id);
}
