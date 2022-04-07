// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SmartApartment {

    struct ParkingVehicle{
        uint id; 
        string vehicleNo;
        string slotId;
        string timestamp;
        bool typeOfEntry;
    }

    ParkingVehicle[] public parkingLot;

    event parked(string indexed _vehicleNo, uint  _id );
    event unparked(string indexed _vehicleNo, uint  _id );


    function enterParkingLot(string memory _vehicleNo, string memory _slotId,string memory _timestamp) public returns (uint) 
    {

      uint _id = parkingLot.length;
      parkingLot.push(
          ParkingVehicle(
          _id,
          _vehicleNo,
          _slotId,
          _timestamp,
          false
          )
      );

      emit parked(_vehicleNo,_id);
      return _id;
    }

    function exitParkingLot(string memory _vehicleNo, string memory _slotId,string memory _timestamp) public returns (uint)
    {

      uint _id = parkingLot.length;
      parkingLot.push(
          ParkingVehicle(
          _id,
          _vehicleNo,
          _slotId,
          _timestamp,
          true
          )
      );
      emit unparked(_vehicleNo,_id);
      return _id;
    }
}