package basicServlet;

import java.io.IOException;
import java.net.InetSocketAddress;

import com.sun.net.httpserver.*;

public class httpServlet {
    
    private httpServlet() {
    }

    public static String CUSTOM_NAME;
    public static String CUSTOM_PORT;
public static void main(String[] args)
{
    CUSTOM_NAME = System.getProperty("CUSTOM_NAME");
    CUSTOM_PORT = System.getProperty("CUSTOM_PORT");

    httpServlet hs=new httpServlet();
    try
    {
    hs.callClass();
    }
    catch(IOException io)
    {
        System.out.println(io);
    }
}

    private void callClass() throws IOException{
        
    int port = 9000;
    if(CUSTOM_PORT!=null && CUSTOM_PORT!="")
{
port=Integer.parseInt(CUSTOM_PORT);
}

HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);

server.createContext("/", new RootHandler());
server.createContext("/echoHeader", new EchoHeaderHandler());
if(CUSTOM_NAME!=null && CUSTOM_NAME!="")
{
server.createContext("/"+CUSTOM_NAME, new EchoCustomHandler(CUSTOM_NAME));
}
else
System.out.println("Custom context is null ");
server.createContext("/echoGet", new EchoGetHandler());
//server.createContext("/echoPost", new EchoPostHandler());
server.setExecutor(null);
server.start();
    }
}