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
      provides sendMessage
    }
     
    global {
      base_url = "https://api.twilio.com"
      _to = "18013687125"
      _from = "13612983151"
      _body = "This is a test from BRADLEY Twilio API"
      
      sendMessage = defaction(_to, _from, _body) {
        auth = {"api_key":apiKey,"session_id":sessionID}
        body = {"To":_to, "From":_from, "Body":_body}
        http:post(<<#{base_url}/2010-04-01/Accounts/#{sessionID}/Messages.json>>, auth=auth, form=body)
        setting(response)
        return response
      }
    }
  }