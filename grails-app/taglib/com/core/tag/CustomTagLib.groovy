package com.core.tag

class CustomTagLib {
    def access = {attrs, body ->
        if (hasAccess(attrs)) {
            out << body()
        }
    }
	
    protected boolean hasAccess(attrs){
        def result = true
        /*
        def urls = attrs.remove("urls")
        urls = urls.split("\\|")		
        def auth = springSecurityService.authentication
        def result = false
        if(urls.size() > 0){
            def linkAttrs = [:]
            urls.each{
                def urlPath = it.split("\\.")
                if(urlPath.size() > 1){
                    linkAttrs.action = urlPath[1]
                }else{
                    linkAttrs.action = "*"
                }
                linkAttrs.controller = urlPath[0]				
                def url = applicationTagLib.createLink(linkAttrs).encodeAsHTML().toString()
                if(webInvocationPrivilegeEvaluator.isAllowed(url, auth)){
                    result = true
                    return
                }
            }			
        }
        */
        //log.debug "$urls $result"
        return result
    }
	
    def menuSub = {attrs, body->
        def current = attrs.current
        def currentUrl = controllerName+"."+actionName
        attrs.urls = current
        if(hasAccess(attrs)){
            def correct = attrs.correct == "true" ? true : false
            if(currentUrl =~ current){
                out << "<li><a href='$attrs.link' class='current'>"+body()+"</a></li>"
            }else{
                if(!correct)
                out << "<li><a href='$attrs.link'>"+body()+"</a></li>"
            }
        }		
    }

    def menuMain = {attrs, body->
        def current = attrs.current
        def currentUrl = controllerName+"."+actionName
        //println "currentUrl ${currentUrl}, ${current}"
        attrs.urls = current
        //log.debug "current $current  ============"
        if(hasAccess(attrs)){
            if(currentUrl =~ current){
                out << "<li><a href='$attrs.link' class='current'>$attrs.message</a>"
                out << "  <ul>"
                out << body()
                out << "   </ul>"
                out << "</li>"
            }else{
                out << "<li><a href='$attrs.link'>$attrs.message</a>"
                out << "  <ul>"
                out << body()
                out << "   </ul>"
                out << "</li>"
            }
        }
    }
	
    def showOnly = { attrs, body->
        def current = attrs.current
        def currentUrl = controllerName+"."+actionName
        //log.debug("body => $body")
        if(currentUrl =~ current){
            out << body()
        }
    }
}
