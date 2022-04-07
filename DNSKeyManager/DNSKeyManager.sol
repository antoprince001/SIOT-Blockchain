// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DNSKeyManager {

    enum DeviceType{
        APARTMENT,
        VEHICLE,
        MALL
    }

    struct KeyPair{
        string publicKey;
        string privateKey;
    }


    struct Domain{
        string domainLocator;
        string lat;
        string long;
        uint networkId;
        string category;
        bool exists;
    }
    
    struct Device{
        uint deviceId;
        address owner;
        string deviceMapper;
        string lat;
        string long;
        KeyPair keyPair;
        DeviceType deviceType ;
        bool exists;
    }

    Domain[] public domains;
    Device[] private devices;

    mapping (uint => string) public nameServer;
    mapping (string => uint) public domainServer;

    function getKeyPair(uint deviceId) public view returns(string memory,string memory) {
        require(
            msg.sender == devices[deviceId].owner,
            "Only owner can access key."
        );

        return (devices[deviceId].keyPair.publicKey,  devices[deviceId].keyPair.privateKey);
    }

    function getOwner(uint deviceId) external view returns (address) {
        
        return devices[deviceId].owner;
    }

    function registerDomain(string memory _domainLocator , string memory _lat , string memory _long,uint _networkId, string memory _category) public returns(uint) {
        
        uint domain_id = domains.length; 
        Domain memory new_domain = Domain(_domainLocator,_lat,_long,_networkId,_category,true);
        domains.push(new_domain);

        domainServer[_domainLocator] = domain_id;

        return domain_id;
    }

   function addDevice(uint deviceType , string memory _deviceMapper, string memory _lat, string memory _long, string memory publicKey, string memory privateKey, string memory _domainLocator) public returns(uint,uint){

        uint device_id = devices.length;
        DeviceType device_type;
        if(deviceType == 0){
            device_type = DeviceType.APARTMENT;
        }
        else if(deviceType == 1){
            device_type = DeviceType.VEHICLE;
        }
        else if(deviceType == 2){
            device_type = DeviceType.MALL;
        }
        KeyPair memory keyPair = KeyPair(publicKey,privateKey);
        Device memory new_device = Device(device_id,msg.sender,_deviceMapper,_lat,_long,keyPair,device_type,true);
        devices.push(new_device);
                
        uint domain_id = domainServer[_domainLocator];
        nameServer[device_id] = _domainLocator;

        return (device_id,domain_id);
   }    
   
    
    function dnsLookup(uint deviceId) public view returns (string memory,string memory,uint){
        
        string memory _domainLocator = nameServer[deviceId];
        uint domain_id = domainServer[_domainLocator];
        Domain memory curr_domain = domains[domain_id];
        return (curr_domain.lat,curr_domain.long,curr_domain.networkId);
    }
}