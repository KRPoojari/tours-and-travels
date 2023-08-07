public class BookingRequest {
    private String requestId;
    private String userId;
    private String locationId;
    private String hotelId;
    private String cabId;
    private List<String> facilityIds;
    private double totalCost;
    private String status; // Pending, Confirmed, Rejected, Completed, etc.
    // Other booking request-related fields, getters, and setters
}

