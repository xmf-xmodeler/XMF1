package IO;

import java.net.*;
import java.io.*;

public class CommandClient {

	// This class implements a protocol for input and output over a network
	// in a client mode. The address of the server must be supplied along with
	// the port number used on the server.
	//
	// To use:
	// (1) Create an instance of the client class.
	// (2) Set the port number.
	// (3) Create an address.
	// (4) Connect to the address.

	Socket socket = null; // Socket created when connected.

	public InetAddress localHost() {
		try {
			return InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			return null;
		}
	}

	public InetAddress address(String address) {
		try {
			return InetAddress.getByName(address);
		} catch (UnknownHostException e) {
			System.out.println("Unknown host: " + address);
			return null;
		}
	}

	public boolean connect(InetAddress address, int port) {
		try {
			socket = new Socket(address, port);
		} catch (IOException ioe) {
			System.out.println(ioe);
			return false;
		}
		try {
            OutputStream out = socket.getOutputStream();
            PrintWriter pout = new PrintWriter(out);
            InputStream in = socket.getInputStream();
            pout.write("com.ceteva.test\0");
            pout.flush();
            in.read();
			Thread t1 = new IOThread(System.in,out);
			Thread t2 = new IOThread(in,System.out);
            t1.start();
            t2.start();
		} catch (IOException ioe) {
			System.out.println(ioe);
			return false;
		}
		return true;
	}

	public boolean ok() {
		// Use this to test whether a client is stil
		// valid for use.
		return !socket.isClosed() && socket.isConnected() && socket.isBound();
	}
	
	public static void main(String[] args) {
		CommandClient client = new CommandClient();
		while(!client.connect(client.localHost(),Integer.parseInt(args[0]))) {}
	}

}