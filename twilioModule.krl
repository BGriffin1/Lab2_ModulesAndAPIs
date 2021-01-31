ruleset twilio_module {
    meta {
      name "Twilio Module"
      description <<
  A ruleset that builds a Twilio API for personal use
  >>
      author "Bradley Griffin"
      configure using
      apiKey = ""
      sessionID = ""
      provides sendMessage, messages
    }
     
    global {
      base_url = "https://api.twilio.com"

      messages = function(_to, _from, page_size) {
        q_init = {"To":_to, "From":_from, "page-size":page_size}
        query_string = (q_init.filter(function(v,k){not v.isnull() && v != ""})).klog("message log")
       

        response = http:get(<<https://#{sessionID}:#{apiKey}@api.twilio.com/2010-04-01/Accounts/#{sessionID}/Messages.json>>, qs = query_string);
        response{"content"}.decode(){"messages"}
      }
      
      sendMessage = defaction(_to, _from, _body) {
        auth = {"api_key":apiKey,"session_id":sessionID}
        body = {"To":_to, "From":_from, "Body":_body}
        http:post(<<https://api.twilio.com/2010-04-01/Accounts/#{sessionID}/Messages.json>>, auth=auth, form=body)
        setting(response)
        return response
      }
    }
  }