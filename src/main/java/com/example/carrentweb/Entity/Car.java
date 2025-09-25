package com.example.carrentweb.Entity;

public class Car {
    private int id;
    private String name;
    private String type;
    private double price;
    private String image;

    public Car(int id, String name, String type, double price, String image) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.price = price;
        this.image = image;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getType() { return type; }
    public double getPrice() { return price; }
    public String getImage() { return image; }

    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setType(String type) { this.type = type; }
    public void setPrice(double price) { this.price = price; }
    public void setImage(String image) { this.image = image; }
}
