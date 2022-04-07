// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SmartMall {

    struct ShopPurchase{
        uint id; 
        string shopId;
        string customerId;
        string purchaseHistory;
        string paymentType;
        uint shopRating;
        uint spendingScore;
    }

    ShopPurchase[] public purchases;

    event Purchase(string indexed _shopId, string indexed _customerId, uint  _id );

    function addPurchase(string memory _shopId, string memory _customerId,string memory _purchaseHistory,string memory _paymentType,uint _shopRating,uint _spendingScore) public returns (uint) 
    {

      uint _id = purchases.length;
      purchases.push(
          ShopPurchase(
          _id,
          _shopId,
          _customerId,
          _purchaseHistory,
          _paymentType,
          _shopRating,
          _spendingScore
          )
      );

      emit Purchase(_shopId,_customerId,_id);
      return _id;
    }

}