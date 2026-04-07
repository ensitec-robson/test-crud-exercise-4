package com.robson.entity;

import java.util.UUID;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "products")
public class Product extends PanacheEntityBase {

    @Id
    public String id;

    @Column(nullable = false, length = 120)
    public String title;

    @Column(nullable = false, length = 500)
    public String description;

    @Column(nullable = false)
    public Double price;

    @Column(name = "image_url", nullable = false, length = 1000)
    public String imageUrl;

    @Column(name = "is_favorite", nullable = false)
    public Boolean isFavorite;

    @PrePersist
    public void prePersist() {
        if (this.id == null || this.id.isBlank()) {
            this.id = UUID.randomUUID().toString();
        }

        if (this.isFavorite == null) {
            this.isFavorite = false;
        }
    }
}