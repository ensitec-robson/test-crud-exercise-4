package com.robson.service;

import java.util.List;

import com.robson.dto.ProductRequestDto;
import com.robson.dto.ProductResponseDto;
import com.robson.entity.Product;
import com.robson.exception.BusinessException;
import com.robson.mapper.ProductMapper;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.NotFoundException;

@ApplicationScoped
public class ProductService {

    public List<ProductResponseDto> listAll() {
        List<Product> products = Product.listAll();
        return products.stream()
                .map(ProductMapper::toResponse)
                .toList();
    }

    public ProductResponseDto findById(String id) {
        Product product = Product.findById(id);

        if (product == null) {
            throw new jakarta.ws.rs.NotFoundException("Produto não encontrado com id: " + id);
        }

        return ProductMapper.toResponse(product);
    }

    @Transactional
    public ProductResponseDto create(ProductRequestDto dto) {
        validateProduct(dto);

        Product product = ProductMapper.toEntity(dto);
        product.persist();

        return ProductMapper.toResponse(product);
    }

    @Transactional
    public ProductResponseDto update(String id, ProductRequestDto dto) {
        validateProduct(dto);

        Product product = Product.findById(id);

        if (product == null) {
            throw new NotFoundException("Produto não encontrado com id: " + id);
        }

        product.title = dto.title;
        product.description = dto.description;
        product.price = dto.price;
        product.imageUrl = dto.imageUrl;

        return ProductMapper.toResponse(product);
    }

    @Transactional
    public void delete(String id) {
        Product product = Product.findById(id);

        if (product == null) {
            throw new NotFoundException("Produto não encontrado com id: " + id);
        }

        product.delete();
    }

    private void validateProduct(ProductRequestDto dto) {
        if (dto == null) {
            throw new BusinessException("Os dados do produto são obrigatórios.");
        }

        if (dto.title == null || dto.title.isBlank()) {
            throw new BusinessException("O título do produto é obrigatório.");
        }

        if (dto.description == null || dto.description.isBlank()) {
            throw new BusinessException("A descrição do produto é obrigatória.");
        }

        if (dto.price == null || dto.price <= 0) {
            throw new BusinessException("O preço do produto deve ser maior que zero.");
        }

        if (dto.imageUrl == null || dto.imageUrl.isBlank()) {
            throw new BusinessException("A URL da imagem é obrigatória.");
        }
    }

    @Transactional
public ProductResponseDto updateFavorite(String id, Boolean isFavorite) {
    Product product = Product.findById(id);

    if (product == null) {
        throw new NotFoundException("Produto não encontrado com id: " + id);
    }

    if (isFavorite == null) {
        throw new BusinessException("O campo isFavorite é obrigatório.");
    }

    product.isFavorite = isFavorite;

    return ProductMapper.toResponse(product);
}
}