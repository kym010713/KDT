package com.kdt.project.seller.controller;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.service.ProductService;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductDetail;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/seller")
public class SellerController {
    
    @Autowired
    private ProductService productService;
    
    // 상품 등록 폼 페이지
    @GetMapping("/register")
    public String showProductRegisterForm(Model model) {
        model.addAttribute("productDto", new ProductRegistrationDto());
        model.addAttribute("categories", productService.getAllCategories());
        return "seller/register";
    }
    
    // 상품 목록 조회 페이지
    @GetMapping("/list")
    public String showProductList(@RequestParam(value = "category", required = false) String category,
                                Model model) {
        List<Product> products;
        if (category != null && !category.isEmpty()) {
            products = productService.getProductsByCategory(category);
        } else {
            products = productService.getAllProducts();
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("selectedCategory", category);
        return "seller/list";
    }
    
    // 상품 상세 조회 (AJAX)
    @GetMapping("/product/detail/{productName}")
    @ResponseBody
    public ProductDetail getProductDetail(@PathVariable String productName) {
        return productService.getProductDetail(productName);
    }
    
    // 상품 등록 처리
    @PostMapping("/product/register")
    public String registerProduct(@Valid @ModelAttribute("productDto") ProductRegistrationDto productDto,
                                BindingResult bindingResult,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", productService.getAllCategories());
            return "seller/register";
        }
        
        try {
            productService.registerProduct(productDto);
            redirectAttributes.addFlashAttribute("successMessage", "상품이 성공적으로 등록되었습니다.");
            return "redirect:/seller/product/register";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("categories", productService.getAllCategories());
            return "seller/product-register";
        }
    }
}