int balance = 500;
bool mutex;
#define N 10

#define lock_mutex(mutex)   \
  do                       \
  :: 1 -> atomic {         \
    if                     \
    :: mutex == false ->       \
      mutex = true;           \
      break                \
    fi                     \
  }                        \
  od

#define unlock_mutex(mutex) \
  mutex = false



active proctype Deposit()
{
  byte i;

  do
  :: i < N ->
      lock_mutex(mutex);
      balance = balance + 100;
      printf("Deposit: Depositing $100. New balance: $%d\n", balance);
      unlock_mutex(mutex);
      i = i + 1;
  od;
}

active proctype Withdraw()
{
  byte i;

  do
  :: i < N ->
      lock_mutex(mutex);
      balance = balance - 50;
      printf("Withdraw: Withdrawing $50. New balance: $%d\n", balance);
      unlock_mutex(mutex);
      i = i + 1;
  od;
}
