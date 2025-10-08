package com.example.carrentweb.Entity;

public class Car {
    private int id;
    private String name;
    private String type;
    private double price;
    private String image;
    private String registrationNumber;
    private int mileage;
    private String condition;
    private boolean available;

    public Car(int id, String name, String type, double price, String image, String registrationNumber, int mileage, String condition, boolean available) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.price = price;
        this.image = image;
        this.registrationNumber = registrationNumber;
        this.mileage = mileage;
        this.condition = condition;
        this.available = available;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getType() { return type; }
    public double getPrice() { return price; }
    public String getImage() { return image; }
    public String getRegistrationNumber() { return registrationNumber; }
    public int getMileage() { return mileage; }
    public String getCondition() { return condition; }
    public boolean isAvailable() { return available; }

    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setType(String type) { this.type = type; }
    public void setPrice(double price) { this.price = price; }
    public void setImage(String image) { this.image = image; }
    public void setRegistrationNumber(String registrationNumber) { this.registrationNumber = registrationNumber; }
    public void setMileage(int mileage) { this.mileage = mileage; }
    public void setCondition(String condition) { this.condition = condition; }
    public void setAvailable(boolean available) { this.available = available; }
}
