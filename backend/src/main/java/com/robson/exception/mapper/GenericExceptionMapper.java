package com.robson.exception.mapper;

import java.time.LocalDateTime;

import com.robson.dto.ErrorResponseDto;

import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

@Provider
public class GenericExceptionMapper implements ExceptionMapper<Exception> {

    @Context
    UriInfo uriInfo;

    @Override
    public Response toResponse(Exception exception) {
        ErrorResponseDto error = new ErrorResponseDto(
                LocalDateTime.now().toString(),
                Response.Status.INTERNAL_SERVER_ERROR.getStatusCode(),
                "Erro interno do servidor.",
                "/" + uriInfo.getPath()
        );

        exception.printStackTrace();

        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                .entity(error)
                .build();
    }
}