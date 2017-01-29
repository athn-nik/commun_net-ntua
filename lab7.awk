BEGIN {
	time_blue = 0;
	time_red = 0;
	packets_blue = 0;
	packets_red = 0;
}
/^r/&&/ack/ {
	if ($4 == 0) {
		time_blue = $2;
		packets_blue++;
	}
	if ($4 == 4) {
		time_red = $2;
		packets_red++;
	}
}
END {
	printf("Packets in blue flow received\t\t: %d\n", packets_blue-1);
	printf("Last aknowledgement received at\t\t: %s sec\n", time_blue);
	printf("Packets in red flow received\t\t: %d\n", packets_red-1);
	printf("Last aknowledgement received at\t\t: %s sec\n", time_red);
}