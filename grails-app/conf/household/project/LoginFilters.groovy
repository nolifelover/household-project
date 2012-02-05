package household.project

class LoginFilters {
    def messageSource
    
    def filters = {
        all(controller:'*', action:'*') {
            before = {
                if(controllerName!='authentication'){
                    def logined = session.logined
                    if(!logined){
                        flash.message =  messageSource.getMessage("authentication.login.before", null, new java.util.Locale("EN"))
                        flash.css = 'error'
                        redirect(controller: 'authentication', action:'login')
                    }
                }  
            }            
        }
    }
    
}
