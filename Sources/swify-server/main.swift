import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"

var routes = Routes()

func returnJSONMessage(message: String, response: HTTPResponse) {
    do {
        try response.setBody(json: ["message": message])
            .addHeader(.contentType, value: "application/json")
            .completed()
    } catch {
        response.setBody(string: "Error Occured : \(error)")
            .completed(status: .internalServerError)
    }
}

routes.add(method: .get, uri: "/", handler: {
    request, response in
    returnJSONMessage(message: "Hello Guest!", response: response)
})

routes.add(method: .get, uri: "/hello", handler: {
    request, response in
    returnJSONMessage(message: "Hello Guest!", response: response)
})

routes.add(method: .get, uri: "/hello/{name}", handler: {
    request, response in
    var name = request.urlVariables["name"] ?? "Guest"
    if(name.count == 0) {
        response.setBody(string: "Bad Request")
            .completed(status: .badRequest)
    }
    if(name.last == "/" && name.count == 1){
        name = "Guest"
    }
    returnJSONMessage(message: "Hello \(name)!", response: response)
})

server.addRoutes(routes)

do {
   try server.start()
} catch PerfectError.networkError(let error, let message) {
    print("Network error thrown \(error) : \(message)" )
}
