WE ARE BASED#

/**
 *Submitted for verification at basescan.org on 2025-02-23
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionTracker {
    uint256 public thresholdAmount = 10 ether;  // Seuil pour marquer les transactions importantes
    address public owner;

    // Struct pour enregistrer les informations d'une transaction importante
    struct ImportantTransaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
    }

    // Liste des transactions importantes
    ImportantTransaction[] public importantTransactions;

    // Event pour notifier une transaction importante
    event ImportantTransactionRecorded(address indexed from, address indexed to, uint256 amount, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Seul le proprietaire peut modifier le seuil");
        _;
    }

    constructor() {
        owner = msg.sender;  // Le créateur du contrat devient le propriétaire
    }

    // Fonction pour changer le seuil des transactions importantes
    function setThreshold(uint256 _threshold) external onlyOwner {
        thresholdAmount = _threshold;
    }

    // Fonction pour enregistrer une transaction importante
    function recordTransaction(address _from, address _to, uint256 _amount) external {
        if (_amount >= thresholdAmount) {
            // Si le montant dépasse le seuil, on enregistre la transaction comme importante
            importantTransactions.push(ImportantTransaction({
                from: _from,
                to: _to,
                amount: _amount,
                timestamp: block.timestamp
            }));
            emit ImportantTransactionRecorded(_from, _to, _amount, block.timestamp);
        }
    }

    // Fonction pour récupérer les transactions importantes
    function getImportantTransactions() external view returns (ImportantTransaction[] memory) {
        return importantTransactions;
    }
}
