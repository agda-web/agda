// a shim for WASI missing tzset function
int tzset() { return 0; }
