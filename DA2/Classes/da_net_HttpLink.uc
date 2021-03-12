class da_net_HttpLink extends BufferedTcpLink;

var string content, path;
var int code;
var bool bError;
var bool bReceivedHeader;

function PostBeginPlay()
{
    Super.PostBeginPlay();
    Disable('Tick');
}

event Opened() {
	local string request;
    Enable('Tick');
	request = "GET"@path@"HTTP/1.0"$CRLF;
	request $= "User-Agent: DA2UTHTTPCLIENT/1.0"$CRLF;
	
	sendBufferedData(request$CRLF);
}

function Tick(float DeltaTime) {
    DoBufferQueueIO();

    Super.Tick(DeltaTime);
}

event Resolved( IpAddr Addr ) {
	addr.port = 80;
	if (bindPort() != 0) 
		open(addr);
}

function GETRequest(String host, String path) {
	resetBuffer();
	content = "";
	code = -1;
	bReceivedHeader = false;
	bError = false;
	self.path = path;
	log("Connecting to http://"$host);
	resolve(host);
}

delegate contentReceived(String data);

// ReceivedText: Called when data is received and connection mode is MODE_Text.
event ReceivedText(string data) {
	local string line;

	if (bError)
		return;
	
	content $= data;
	
	while (!bReceivedHeader && !bError && len(content) > 0 && instr(content, chr(13)) > 1) {
		line = left(content, instr(content, chr(13)));
//		log("R:"@line);
		if (code < 0) {
			if (left(line,5) != "HTTP/")
				bError = true;
			else {
				line = left(mid(line, 1 + instr(line, " ")), 3);
				code = int(line);				
			}
		}
		
		content = mid(content, 1 + instr(content, chr(13)));
	}
	bReceivedHeader = instr(content, chr(13)) >= 0 && instr(content, chr(13)) < 2;
	
//	log("B:"@bReceivedHeader@bError@code);	
	if (bError || ( code >= 0 && code != 200)) {
		content = "";
		bError = true;
	}

	if (bError || len(content) > 0)
		contentReceived(content);
}

defaultproperties
{
}
