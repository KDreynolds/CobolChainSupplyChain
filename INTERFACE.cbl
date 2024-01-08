       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUPPLY-CHAIN-INTERFACE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CONSOLE IS SYSIN.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SUPPLY-CHAIN-FILE ASSIGN TO "SUPPLYCHAIN.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ITEM-ID
               FILE STATUS IS FS-SUPPLY-CHAIN.

       DATA DIVISION.
       FILE SECTION.

       FD SUPPLY-CHAIN-FILE.
       01 SUPPLY-CHAIN-RECORD-DATA.
           COPY SUPPLY-CHAIN-RECORD.

       WORKING-STORAGE SECTION.
       01 FS-SUPPLY-CHAIN      PIC XX.
       01 WS-OPTION            PIC X(1).
       01 WS-INPUT-BUFFER      PIC X(255).
       01 WS-END-OF-FILE       PIC X(3) VALUE "NO".

       01 WS-SUPPLY-CHAIN-RECORD.
           COPY SUPPLY-CHAIN-RECORD.

       PROCEDURE DIVISION.

       DISPLAY "SUPPLY CHAIN MANAGEMENT SYSTEM".
       DISPLAY "SELECT OPTION:".
       DISPLAY "1 - ADD SUPPLY CHAIN RECORD".
       DISPLAY "2 - UPDATE SUPPLY CHAIN RECORD".
       DISPLAY "3 - DELETE SUPPLY CHAIN RECORD".
       DISPLAY "4 - EXIT".
       ACCEPT WS-OPTION FROM CONSOLE.

       EVALUATE WS-OPTION
           WHEN "1"
               PERFORM ADD-SUPPLY-CHAIN-RECORD
           WHEN "2"
               PERFORM UPDATE-SUPPLY-CHAIN-RECORD
           WHEN "3"
               PERFORM DELETE-SUPPLY-CHAIN-RECORD
           WHEN "4"
               MOVE "YES" TO WS-END-OF-FILE
           WHEN OTHER
               DISPLAY "INVALID OPTION"
       END-EVALUATE.

       PERFORM UNTIL WS-END-OF-FILE = "YES"
           DISPLAY "SELECT OPTION:".
           DISPLAY "1 - ADD SUPPLY CHAIN RECORD".
           DISPLAY "2 - UPDATE SUPPLY CHAIN RECORD".
           DISPLAY "3 - DELETE SUPPLY CHAIN RECORD".
           DISPLAY "4 - EXIT".
           ACCEPT WS-OPTION FROM CONSOLE.

           EVALUATE WS-OPTION
               WHEN "1"
                   PERFORM ADD-SUPPLY-CHAIN-RECORD
               WHEN "2"
                   PERFORM UPDATE-SUPPLY-CHAIN-RECORD
               WHEN "3"
                   PERFORM DELETE-SUPPLY-CHAIN-RECORD
               WHEN "4"
                   MOVE "YES" TO WS-END-OF-FILE
               WHEN OTHER
                   DISPLAY "INVALID OPTION"
           END-EVALUATE
       END-PERFORM.

       STOP RUN.

       ADD-SUPPLY-CHAIN-RECORD.
           CALL "SUPPLY-CHAIN-MANAGEMENT" USING WS-SUPPLY-CHAIN-RECORD.
           PERFORM FILE-STATUS-CHECK.

       UPDATE-SUPPLY-CHAIN-RECORD.
           CALL "SUPPLY-CHAIN-MANAGEMENT" USING WS-SUPPLY-CHAIN-RECORD.
           PERFORM FILE-STATUS-CHECK.

       DELETE-SUPPLY-CHAIN-RECORD.
           CALL "SUPPLY-CHAIN-MANAGEMENT" USING WS-SUPPLY-CHAIN-RECORD.
           PERFORM FILE-STATUS-CHECK.

       FILE-STATUS-CHECK.
           IF FS-SUPPLY-CHAIN NOT = "00"
               DISPLAY "ERROR IN SUPPLY-CHAIN-FILE: " FS-SUPPLY-CHAIN
           END-IF.

       END PROGRAM SUPPLY-CHAIN-INTERFACE.
