

// TransactionModel transactionModelFromJson(String str) =>
//     TransactionModel.fromJson(json.decode(str));

// String transactionModelToJson(TransactionModel data) =>
//     json.encode(data.toJson());

class TransactionModel {
  bool? status;
  List<Transaction>? transaction;

  TransactionModel({this.status, this.transaction});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  dynamic account;
  dynamic accountType;
  dynamic invoiceId;
  dynamic createdAt;
  dynamic balance;
  dynamic recordType;
  dynamic counterParty;
  dynamic transactionType;
  dynamic transactionAmount;

  Transaction({
    this.account,
    this.accountType,
    this.balance,
    this.counterParty,
    this.createdAt,
    this.invoiceId,
    this.recordType,
    this.transactionAmount,
    this.transactionType,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    accountType = json['account_type'];
    counterParty = json['counter_party'];
    transactionType = json['transaction_type'];
    transactionAmount = json['transaction_amount'];
    recordType = json['record_type'];
    createdAt = json['createdAt'];
    balance = json['balance'];
    invoiceId = json['invoice_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['counter_party'] = this.counterParty;
    data['invoice_id'] = this.invoiceId;
    data['balance'] = this.balance;
    data['record_type'] = this.recordType;
    data['createdAt'] = this.createdAt;

    data['transaction_type'] = this.transactionType;
    data['transaction_amount'] = this.transactionAmount;

    return data;
  }
}
