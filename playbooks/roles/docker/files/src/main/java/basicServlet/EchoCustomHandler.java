package basicServlet;
import java.io.IOException;
import java.io.OutputStream;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;

public class EchoCustomHandler implements HttpHandler {
    public String customContext=null;
    public EchoCustomHandler(String context) {
        customContext=context;
    }
    
    @Override
    public void handle(HttpExchange he) throws IOException {
            String response = "<h1>Hello </h1>" + "<h1> " + customContext + "</h1>";
            he.sendResponseHeaders(200, response.length());
            OutputStream os = he.getResponseBody();
            os.write(response.getBytes());
            os.close();
    }


}