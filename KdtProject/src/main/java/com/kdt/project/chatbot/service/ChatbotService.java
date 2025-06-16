package com.kdt.project.chatbot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdt.project.chatbot.entity.FaqEntry;
import com.kdt.project.chatbot.repository.FaqRepository;
import com.kdt.project.order.dto.OrderDetailDTO;
import com.kdt.project.order.dto.OrderSummaryDTO;
import com.kdt.project.order.repository.OrderDetailRepository;
import com.kdt.project.order.repository.OrderRepository;

import java.util.List;

@Service
public class ChatbotService {
	
	@Autowired
	private OrderRepository ordersRepository;
	@Autowired
	private OrderDetailRepository orderDetailRepository;
	
	@Autowired
	FaqRepository faqRepository;
	
	public boolean containsIgnoreWhitespace(String source, String target) {
	    if (source == null || target == null) return false;
	    String sourceNoSpace = source.replaceAll("\\s+", "");
	    String targetNoSpace = target.replaceAll("\\s+", "");
	    return sourceNoSpace.contains(targetNoSpace);
	}

    public String getAnswer(String userInput, String userId) {
    	
    	  //"주문내역", "내 주문" 등 키워드 감지
        if (containsIgnoreWhitespace(userInput, "주문내역") || containsIgnoreWhitespace(userInput, "내 주문")) {
            return getOrderHistory(userId);
        }
    	
        List<FaqEntry> faqList = faqRepository.findAll();
        int no = 1;
        for (FaqEntry entry : faqList) {
        	if (containsIgnoreWhitespace(userInput, entry.getKeyword())) {
                return entry.getAnswer();
            }
        }

        return "죄송합니다. 질문을 이해하지 못했습니다.";
    }
    
    public String getOrderHistory(String userId) {
        List<OrderSummaryDTO> summaries = ordersRepository.findOrderSummaries(userId);

        if (summaries.isEmpty()) {
            return "주문 내역이 없습니다.";
        }

        StringBuilder sb = new StringBuilder("고객님의 최근 주문 내역입니다:<br>");
        for (OrderSummaryDTO summary : summaries) {
        	sb.append("배송상태: ").append(summary.getDeliveryStateText()).append("<br>");

            sb.append("- 주문번호: ").append(summary.getOrderGroup())
              .append(", 날짜: ").append(summary.getOrderDate())
              .append("<br>상품 내역<br>");

            List<OrderDetailDTO> details = orderDetailRepository.findDetailsByOrderGroup(summary.getOrderGroup());
            for (OrderDetailDTO detail : details) {
                sb.append("상품명: ").append(detail.getProductName())
                  .append(", 수량: ").append(detail.getQuantity())
                  .append("<br>");
            }
            sb.append("<br>");
        }
        return sb.toString();
    }


}
