package com.core

class AuthenticationController {

    def index = { }
    
    def login = {        
    }
    
    def doLogin = {
        try{
            def user = User.findByUsernameAndPassword(params.username, params.password)
            if(user){
                session.logined = true
                session.user = user
                flash.css = 'info'
                flash.message = message(code:'authentication.login.success')
                redirect(controller:'account', action:'index')
            }else{
                flash.css = 'error'
                flash.message = message(code:'authentication.login.fail')
                redirect(controller:'authentication', action:'login')
            }
        }catch(Exception e){
            flash.css = 'error'
            flash.message = message(code:'authentication.login.params_missing')
            redirect(controller:'authentication', action:'login')
        }        
    }
    
    def logout = {
        def logined = session.logined
        if(logined){
            session.logined = null
            session.user = null
            flash.css = 'info'
            flash.message = message(code:'authentication.logout.success')
            redirect(controller:'authentication', action:'login')
        }else{
            session.logined = null
            flash.css = 'info'
            flash.message = message(code:'authentication.logout.fail')
            redirect(controller:'authentication', action:'login')
        }
    }   
    
}
