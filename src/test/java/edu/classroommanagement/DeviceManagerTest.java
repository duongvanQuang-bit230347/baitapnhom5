package edu.classroommanagement;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.MockitoAnnotations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

class DeviceManagerTest {

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private ResultSet generatedKeys;

    @InjectMocks
    private DeviceManager deviceManager;

    private MockedStatic<DatabaseConnection> mockedStatic;

    @BeforeEach
    void setUp() throws SQLException {
        MockitoAnnotations.openMocks(this);
        mockedStatic = mockStatic(DatabaseConnection.class); // Mock static method
        mockedStatic.when(DatabaseConnection::getConnection).thenReturn(connection);
        when(connection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenReturn(preparedStatement);
    }

    @AfterEach
    void tearDown() {
        mockedStatic.close(); // Close the static mock
    }

    @Test
    void testAddDeviceSuccess() throws SQLException {
        Device device = new Device(
            "Projector",
            1,
            "ACTIVE",
            "Good condition"
        );

        when(preparedStatement.executeUpdate()).thenReturn(1);
        when(preparedStatement.getGeneratedKeys()).thenReturn(generatedKeys);
        when(generatedKeys.next()).thenReturn(true);
        when(generatedKeys.getInt(1)).thenReturn(100);

        deviceManager.addDevice(device);

        assertEquals(100, device.getId(), "Device ID should be set to 100");
        verify(connection).prepareStatement(
            eq("INSERT INTO devices (name, room_id, status, condition_notes) VALUES (?, ?, ?, ?)"),
            eq(Statement.RETURN_GENERATED_KEYS)
        );
        verify(preparedStatement).setString(1, device.getName());
        verify(preparedStatement).setInt(2, device.getRoomId());
        verify(preparedStatement).setString(3, device.getStatus());
        verify(preparedStatement).setString(4, device.getConditionNotes());
        verify(preparedStatement).executeUpdate();
        verify(preparedStatement).getGeneratedKeys();
        verify(generatedKeys).next();
        verify(generatedKeys).getInt(1);
    }

    @Test
    void testAddDeviceNoRowsAffected() throws SQLException {
        Device device = new Device(
            "Projector",
            1,
            "ACTIVE",
            "Good condition"
        );

        when(preparedStatement.executeUpdate()).thenReturn(0);

        SQLException thrown = assertThrows(SQLException.class, () -> deviceManager.addDevice(device),
            "Expected SQLException when no rows are affected");
        assertEquals("Thêm thiết bị thất bại, không có hàng nào bị ảnh hưởng.", thrown.getMessage());
        verify(preparedStatement).executeUpdate();
        verify(preparedStatement, never()).getGeneratedKeys();
    }

    @Test
    void testAddDeviceNoGeneratedKeys() throws SQLException {
        Device device = new Device(
            "Projector",
            1,
            "ACTIVE",
            "Good condition"
        );

        when(preparedStatement.executeUpdate()).thenReturn(1);
        when(preparedStatement.getGeneratedKeys()).thenReturn(generatedKeys);
        when(generatedKeys.next()).thenReturn(false);

        SQLException thrown = assertThrows(SQLException.class, () -> deviceManager.addDevice(device),
            "Expected SQLException when no generated keys are returned");
        assertEquals("hêm thiết bị thất bại, không lấy được ID.", thrown.getMessage());
        verify(preparedStatement).executeUpdate();
        verify(preparedStatement).getGeneratedKeys();
        verify(generatedKeys).next();
    }
}