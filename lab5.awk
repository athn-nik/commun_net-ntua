BEGIN {
	data=0;
	packets=0;
}
/^r/&&/tcp/ {
	data+=$6;
	packets++;
}
/^r/&&/ack/ {
	time = $2;
}
END {
	printf("Total Data received\t\t\t: %d Bytes\n", data);
	printf("Total Packets received\t\t\t: %d\n", packets);
	printf("Total duration of data transmission\t: %f sec\n", time-0.5);
}