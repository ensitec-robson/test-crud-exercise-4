package com.robson.resourse;

import java.net.URI;
import java.util.List;

import com.robson.dto.FavoriteRequestDto;
import com.robson.dto.ProductRequestDto;
import com.robson.dto.ProductResponseDto;
import com.robson.service.ProductService;

import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PATCH;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/products")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ProductResource {

    @Inject
    ProductService productService;

    @GET
    public List<ProductResponseDto> listAll() {
        return productService.listAll();
    }

    @GET
    @Path("/{id}")
    public ProductResponseDto findById(@PathParam("id") String id) {
        return productService.findById(id);
    }

    @POST
    public Response create(ProductRequestDto dto) {
        ProductResponseDto createdProduct = productService.create(dto);

        return Response
                .created(URI.create("/products/" + createdProduct.id))
                .entity(createdProduct)
                .build();
    }

    @PATCH
    @Path("/{id}/favorite")
    public ProductResponseDto updateFavorite(@PathParam("id") String id, FavoriteRequestDto dto) {
    return productService.updateFavorite(id, dto.isFavorite);
}

    @PUT
    @Path("/{id}")
    public ProductResponseDto update(@PathParam("id") String id, ProductRequestDto dto) {
        return productService.update(id, dto);
    }

    @DELETE
    @Path("/{id}")
    public Response delete(@PathParam("id") String id) {
        productService.delete(id);
        return Response.noContent().build();
    }
}