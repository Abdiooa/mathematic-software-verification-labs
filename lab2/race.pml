#define N 10

int balance = 500;

active proctype Deposit() {
    byte i;
    do
    :: i < N -> 
        balance = balance + 100;
        printf("Deposit: Depositing $100. New balance: $%d\n", balance);
        i = i + 1;
    od;
}

active proctype Withdraw() {
    byte i;
    do
    :: i < N -> 
        balance = balance - 50;
        printf("Withdraw: Withdrawing $50. New balance: $%d\n", balance);
        i = i + 1;
    od;
}
