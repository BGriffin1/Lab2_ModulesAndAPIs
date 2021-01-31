ruleset twilio_app_code {
    meta {
      use module twilio_module alias twilio
        with
          apiKey = meta:rulesetConfig{"api_key"}
          sessionID = meta:rulesetConfig{"session_id"}
    }

    rule send_message {
        select when message send

        twilio:sendMessage(event:attrs{"to"}, event:attrs{"from"}, event:attrs{"message"})

    }
    rule retrieve_messages {
        select when message retrieve
        pre{
            messages = twilio:sendMessage(event:attrs{"to"}, event:attrs{"from"}, event:attrs{"page-size"})
        }
        send_directive("Messages", {"Message": messages})
    }

    

    
  }