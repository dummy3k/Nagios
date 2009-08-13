BEGIN {
	foundVoIP = 0
	
	# 0 = token not found
	# 1 = token found
	# 2 = next line
	outputNext = 0
	
	# output
	output = ""
}

/Empfangene Bytes \(Low\)/ {
	if (foundVoIP == 0 ) {
		outputNext=1
		output = output "RCV:"
	}
} 

/Gesendete Bytes \(Low\)/ {
	if (foundVoIP == 0 ) {
		outputNext=1
		output = output "SND:"
	}
} 

/VoIP/ { foundVoIP = 1 }

{
	if (outputNext==2) {
		if (match($0, "([[:digit:]]+)", matches) == 0) { print "regex didnt match" }
		output = output matches[0] " "
	 	outputNext=0
	}
	if (outputNext==1) {
	 	outputNext=2
	}
}

END {
	print output
}
