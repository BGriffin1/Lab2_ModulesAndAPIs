ruleset twilio_app_code {
    meta {
      use module twilio_module alias twilio
        with
          apiKey = meta:rulesetConfig{"api_key"}
          sessionID = meta:rulesetConfig{"session_id"}
      shares messages
    }
    global{
        // messages() = function() {
        //     twilio:messages()
        }

    rule send_message {
        select when message send

        to re#(\d{9}#
        content re#(.+)$#
        setting(to, content)

        twilio:sendMessage(to.klog("TO: "), content.klog("CONTENT: ")) setting(response)
        send_directive("message sent",{"content":content})
        // fired {
        //     ent:lastResponse := response
        //     ent:lastTimestamp := time:now()
        // }
        raise message event "sent message" attributes event:attrs
        }
    }
  }