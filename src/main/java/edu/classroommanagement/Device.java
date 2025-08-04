package edu.classroommanagement;

public class Device {
    private int id;
    private String name;
    private int roomId;
    private String status;
    private String conditionNotes;

    // Constructors, getters, setters
    public Device() {}
    public Device(String name, int roomId, String status, String conditionNotes) {
        this.name = name;
        this.roomId = roomId;
        this.status = status;
        this.conditionNotes = conditionNotes;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getConditionNotes() { return conditionNotes; }
    public void setConditionNotes(String conditionNotes) { this.conditionNotes = conditionNotes; }
}