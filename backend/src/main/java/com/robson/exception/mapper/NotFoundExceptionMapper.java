package com.robson.exception.mapper;

import java.time.LocalDateTime;

import com.robson.dto.ErrorResponseDto;

import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

@Provider
public class NotFoundExceptionMapper implements ExceptionMapper<NotFoundException> {

    @Context
    UriInfo uriInfo;

    @Override
    public Response toResponse(NotFoundException exception) {
        ErrorResponseDto error = new ErrorResponseDto(
                LocalDateTime.now().toString(),
                Response.Status.NOT_FOUND.getStatusCode(),
                exception.getMessage(),
                uriInfo.getPath()
        );

        return Response.status(Response.Status.NOT_FOUND)
                .entity(error)
                .build();
    }
}
