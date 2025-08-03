package edu.classroommanagement;

public class Room {
    private int id;
    private String roomNumber;
    private int capacity;
    private String status;
    private String location;
    private String notes;

    // Constructors, getters, setters
    public Room() {}
    public Room(String roomNumber, int capacity, String status, String location, String notes) {
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.status = status;
        this.location = location;
        this.notes = notes;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}