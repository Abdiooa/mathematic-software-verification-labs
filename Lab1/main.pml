mtype {PROD, DONE};


proctype Producer(chan c; int count)
{
    byte item;

    printf("PRODUCER: running, pid=%d\n", _pid);

    do
    :: count > 0 ->
        item = count;
        printf("PRODUCER: producing item %d\n", item);
        c ! PROD, item;
        count = count - 1;
    :: count == 0 -> 
        printf("PRODUCER: done producing\n");
        c ! DONE;
        break;
    od
}

proctype Consumer(chan c)
{
    byte item;

    printf("CONSUMER: running, pid=%d\n", _pid);

    do
    :: c ? PROD, item ->
        printf("CONSUMER: consuming item %d\n", item);
    :: c ? DONE ->
        printf("CONSUMER: done consuming\n");
        break;
    od
}

init
{
	chan c = [2] of { mtype, byte }; 
    int count = 5;
    run Producer(c, count);
    run Consumer(c);
}
