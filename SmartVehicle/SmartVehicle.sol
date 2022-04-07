// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SmartVehicle {

    enum RelationshipType{
        POR,
        SFR,
        CLOR
    }

    struct Vehicle{
        uint id; 
        string vehicleNo;
        string lat;
        string long;
        string timestamp;
        RelationshipType rel;
    }

    Vehicle[] public vehicles;

    event POR(string indexed _vehicleNo, uint  _id );
    event SFR(string indexed _vehicleNo, uint  _id );
    event CLOR(string indexed _vehicleNo, uint  _id );


    function addPORVehicle(string memory _vehicleNo, string memory _lat,string memory _long,string memory _timestamp) public returns (uint) 
    {
      uint _id = vehicles.length;
      vehicles.push(
          Vehicle(
          _id,
          _vehicleNo,
          _lat,
          _long,
          _timestamp,
          RelationshipType.POR
          )
      );

      emit POR(_vehicleNo,_id);
      return _id;
    }

    function addSFRVehicle(string memory _vehicleNo, string memory _lat,string memory _long,string memory _timestamp) public returns (uint) 
    {
      uint _id = vehicles.length;
      vehicles.push(
          Vehicle(
          _id,
          _vehicleNo,
          _lat,
          _long,
          _timestamp,
          RelationshipType.SFR
          )
      );

      emit POR(_vehicleNo,_id);
      return _id;
    }

    function addCLORVehicle(string memory _vehicleNo, string memory _lat,string memory _long,string memory _timestamp) public returns (uint) 
    {
      uint _id = vehicles.length;
      vehicles.push(
          Vehicle(
          _id,
          _vehicleNo,
          _lat,
          _long,
          _timestamp,
          RelationshipType.CLOR
          )
      );

      emit POR(_vehicleNo,_id);
      return _id;
    }

}