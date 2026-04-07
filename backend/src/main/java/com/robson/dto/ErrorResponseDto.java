package com.robson.dto;

public class ErrorResponseDto {

    public String timestamp;
    public int status;
    public String message;
    public String path;

    public ErrorResponseDto() {
    }

    public ErrorResponseDto(String timestamp, int status, String message, String path) {
        this.timestamp = timestamp;
        this.status = status;
        this.message = message;
        this.path = path;
    }
}