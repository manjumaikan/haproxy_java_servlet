package basicServlet;
import java.io.IOException;
import java.io.OutputStream;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;



public class RootHandler implements HttpHandler {

    
    String port = "9000";

    @Override
    public void handle(HttpExchange he) throws IOException {
        if(System.getProperty("CUSTOM_PORT")!=null && System.getProperty("CUSTOM_PORT")!="")
        {
    port=System.getProperty("CUSTOM_PORT");
        }
            String response = "<h1>Server start success if you see this message</h1>" + "<h1>Docker Port: " + port + "</h1>";
            he.sendResponseHeaders(200, response.length());
            OutputStream os = he.getResponseBody();
            os.write(response.getBytes());
            os.close();
    }


}