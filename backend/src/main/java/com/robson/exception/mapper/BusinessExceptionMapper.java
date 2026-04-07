package com.robson.exception.mapper;

import java.time.LocalDateTime;

import com.robson.dto.ErrorResponseDto;
import com.robson.exception.BusinessException;

import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

@Provider
public class BusinessExceptionMapper implements ExceptionMapper<BusinessException> {

    @Context
    UriInfo uriInfo;

    @Override
    public Response toResponse(BusinessException exception) {
        ErrorResponseDto error = new ErrorResponseDto(
                LocalDateTime.now().toString(),
                Response.Status.BAD_REQUEST.getStatusCode(),
                exception.getMessage(),
                uriInfo.getPath()
        );

        return Response.status(Response.Status.BAD_REQUEST)
                .entity(error)
                .build();
    }
}