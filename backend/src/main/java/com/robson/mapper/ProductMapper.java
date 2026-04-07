package com.robson.mapper;

import com.robson.dto.ProductRequestDto;
import com.robson.dto.ProductResponseDto;
import com.robson.entity.Product;

public class ProductMapper  {
    public static Product toEntity(ProductRequestDto dto) {
        Product product = new Product();
        product.title = dto.title;
        product.description = dto.description;
        product.price = dto.price;
        product.imageUrl = dto.imageUrl;
        return product;
    }

    public static ProductResponseDto toResponse(Product product) {
        ProductResponseDto dto = new ProductResponseDto();
        dto.id = product.id;
        dto.title = product.title;
        dto.description = product.description;
        dto.price = product.price;
        dto.imageUrl = product.imageUrl;
        dto.isFavorite = product.isFavorite;
        return dto;
    }
}