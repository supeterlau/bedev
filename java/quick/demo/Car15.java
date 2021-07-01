package demo;

public class Car15 extends Vehicle15{
  int numberOfSeats = 0;
  public String getNumbeOfSeats() {
    return String.valueOf(numberOfSeats);
  }
  public String getLicensePlate() {
    return licensePlate;
  }

  @Override
  public void setLicensePlate(String licence) {
    licensePlate = licence.toLowerCase();
  }
}
