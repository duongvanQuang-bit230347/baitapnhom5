package dao;

import java.util.ArrayList;
import java.util.List;

import model.Classroom;

public class ClassroomDAO {

    private static List<Classroom> classrooms = new ArrayList<>();
    private static int nextId = 1;

    public List<Classroom> getAll() {
        return classrooms;
    }

    public void add(Classroom room) {
        room.setId(nextId++);
        classrooms.add(room);
    }
}
