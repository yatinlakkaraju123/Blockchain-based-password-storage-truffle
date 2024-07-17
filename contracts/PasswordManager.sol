pragma solidity >=0.4.22 <0.9.0;
// SPDX-License-Identifier: GPL-3.0

contract PasswordManager {
    struct userpasswords {
        uint VaultID;
        string name;
        string username;
        string password;
    }

    struct vault {
        uint id;
        string username;
        string masterPassword;
    }

    vault[] public Vault;
    userpasswords[] public credentials;
    uint count;

    constructor() {}
   function getAllVaultUsernames() public view returns(string[] memory) {
    uint usernameCount = 0;  // Count the number of usernames

    // Loop to count the usernames
    for (uint i = 0; i < Vault.length; i++) {
        usernameCount++;
    }

    string[] memory usernames = new string[](usernameCount);  // Create an array with the correct size

    // Loop to fill the username array
    uint index = 0;
    for (uint i = 0; i < Vault.length; i++) {
        usernames[index] = Vault[i].username;
        index++;
    }

    return usernames;
}
    function getCredentialNames(uint vid) public view returns(string[] memory)
    {
        string[] memory names = new string[](credentials.length);
        uint count1=0;
        for(uint i=0;i<credentials.length;i++)
        {
            if(vid==credentials[i].VaultID)
            {
                names[count1++] = credentials[i].name;
            }
        }
        assembly {
            mstore(names, count1)
        }

        return names;
    } 
    function isUserName(string memory _username) public view returns (bool)
    {
        bool a = false;
        for(uint i=0;i<Vault.length;i++)
        {
             if(keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(Vault[i].username)))
            {
                a = true;
            } 
        }
        return a;
    }
    function getMasterPassword(string memory _username) public view returns(string memory)
    {   string memory password="";
        for(uint i=0;i<Vault.length;i++)
        {
            if(keccak256(abi.encodePacked(_username)) == keccak256(abi.encodePacked(Vault[i].username)))
            {
                password = Vault[i].masterPassword;
            }
        }
        return password;
    }
    function createNewUser(string memory _username, string memory _masterPassword) public {
        Vault.push(vault({
            id: count,
            username: _username,
            masterPassword: _masterPassword
        }));
        count++;
    }

    function getVaultID(string memory vaultusername, string memory vaultmasterpassword) public view returns (uint) {
        uint vid = 0;
        for (uint i = 0; i < Vault.length; i++) {
            if (keccak256(abi.encodePacked(vaultusername)) == keccak256(abi.encodePacked(Vault[i].username))) {
                if (keccak256(abi.encodePacked(vaultmasterpassword)) == keccak256(abi.encodePacked(Vault[i].masterPassword))) {
                    vid = Vault[i].id;
                }
            }
        }
        return vid;
    }

    function addCredentials(uint vid, string memory _name, string memory _username, string memory _password) public {
        credentials.push(userpasswords({
            VaultID: vid,
            name: _name,
            username: _username,
            password: _password
        }));
    }

    function getCredentialsUserName(uint vid, string memory _name) public view returns (string[] memory) {
        string[] memory usernames = new string[](credentials.length);
        uint count1 = 0;
        for (uint i = 0; i < credentials.length; i++) {
            if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(credentials[i].name)) && vid == credentials[i].VaultID) {
                usernames[count1] = credentials[i].username;
                count1++;
            }
        }
        assembly {
            mstore(usernames, count1)
        }
        return usernames;
    }

    function getCredentialsPassword(uint vid, string memory _name) public view returns (string[] memory) {
        string[] memory usernames = new string[](credentials.length);
        uint count1 = 0;
        for (uint i = 0; i < credentials.length; i++) {
            if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(credentials[i].name)) && vid == credentials[i].VaultID) {
                usernames[count1] = credentials[i].password;
                count1++;
            }
        }
        assembly {
            mstore(usernames, count1)
        }
        return usernames;
    }
}
