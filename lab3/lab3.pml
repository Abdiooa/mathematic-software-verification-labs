mtype = {SYN, SYN_ACK, ACK, DATA, FIN, CLS}

chan ch = [4] of {int, mtype, int}

init {
    atomic {
        run client()
        run server()
    }
}

proctype client() {
    int seq_num = 0
    int ack_num = 0
    int payload = 1000
    
    // Connect to server
    ch!seq_num, SYN, payload
    ch?ack_num, SYN_ACK, payload
    seq_num++
    ack_num++
    
    // Send data
    ch!seq_num, DATA, payload
    ch?ack_num, ACK, payload
    seq_num++
    ack_num++
    
    // Close connection
    ch!seq_num, FIN, payload
    ch?ack_num, CLS, payload
    seq_num++
    ack_num++
}

proctype server() {
    int seq_num = 0
    int ack_num = 0
    int payload = 1000
    
    // Wait for connection request
    ch?seq_num, SYN, payload
    ch!ack_num, SYN_ACK, payload
    seq_num++
    ack_num++
    
    // Receive data
    ch?seq_num, DATA, payload
    ch!ack_num, ACK, payload
    seq_num++
    ack_num++
    
    // Close connection
    ch?seq_num, FIN, payload
    ch!ack_num, CLS, payload
    seq_num++
    ack_num++
}
