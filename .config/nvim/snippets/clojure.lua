return {
		s({ trig = 'api', name = 'BB API test', dscr = 'Babashka HTTP POST test' },
		  fmt([[
		  (require '[babashka.http-client :as http]
						'[cheshire.core :as json])

		(let [api-url "<>"
			  payload {<>}
			  response (http/post api-url
								  {:headers {"Authorization" (str "Bearer " <>)
											 "Content-Type"  "application/json"}
								   :body    (json/generate-string payload)})]
		  (->> response :body (json/parse-string keyword)))
		]], { i(1, "https://api.example.com"), i(2, ":inputs \"test\""), i(3, "token") },
		   { delimiters = '<>' })),
   }
