       01 SUPPLY-CHAIN-RECORD.
           05 ITEM-ID              PIC X(10).
           05 ITEM-DESCRIPTION     PIC X(50).
           05 ITEM-QUANTITY        PIC 9(5).
           05 SUPPLIER-ID          PIC X(10).
           05 SUPPLIER-NAME        PIC X(30).
           05 SHIPMENT-ID          PIC X(15).
           05 SHIPMENT-DATE        PIC 9(8) YYYYMMDD.
           05 RECEIVED-DATE        PIC 9(8) YYYYMMDD.
           05 TRANSACTION-ID       PIC X(20).
           05 TRANSACTION-AMOUNT   PIC 9(7)V99.
           05 TRANSACTION-STATUS   PIC X(10).
           05 AUDIT-TIMESTAMP      PIC 9(14) YYYYMMDDHHMMSS.

       01 BLOCKCHAIN-RECORD.
           05 BLOCK-HASH           PIC X(64).
           05 PREVIOUS-HASH        PIC X(64).
           05 NONCE                PIC 9(10).
           05 DATA-LENGTH          PIC 9(5).
           05 DATA                 PIC X(255).
           05 TIMESTAMP            PIC 9(14) YYYYMMDDHHMMSS.
           05 BLOCK-SIGNATURE      PIC X(128).

       01 TRANSACTION-RECORD.
           05 TX-ID                PIC X(20).
           05 TX-ITEM-ID           PIC X(10).
           05 TX-QUANTITY          PIC 9(5).
           05 TX-SUPPLIER-ID       PIC X(10).
           05 TX-DATE              PIC 9(8) YYYYMMDD.
           05 TX-AMOUNT            PIC 9(7)V99.
           05 TX-STATUS            PIC X(10).
           05 TX-AUDIT-TIMESTAMP   PIC 9(14) YYYYMMDDHHMMSS.
