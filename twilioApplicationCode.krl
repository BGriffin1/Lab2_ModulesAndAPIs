ruleset twilio_app_code {
    meta {
      use module twilio_module alias twilio
        with
          apiKey = meta:rulesetConfig{"api_key"}
          sessionID = meta:rulesetConfig{"session_id"}
    }

    rule send_message {
        select when message send

        twilio:sendMessage(event:attrs{"To"}, event:attrs{"From"}, event:attrs{"Body"})
    
        //send_directive("Message", {"Message": myMessage})

    }
    rule retrieve_messages {
        select when message retrieve
        pre{
            messages = twilio:messages(event:attrs{"To"}, event:attrs{"From"}, event:attrs{"page-size"})
        }
        send_directive("Messages", {"Message": messages})
    }

    

    
  }