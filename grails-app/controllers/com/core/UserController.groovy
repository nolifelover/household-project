package com.core

class UserController {

    def editProfile = {
        def user = session.user
        [userInstance: user]
    }
    
    def updateProfile = {
        def user = session.user
        user.fullname = params.fullname
        user.email = params.email
        if(params.new_password!=null && params.old_password == user.password){
            if(params.new_password == params.new_password_confirm){
                if(user.save(flush:true)){
                    session.user = User.get(user.id)
                    flash.message = message(code:'user.profile.update.success')
                    flash.css = 'info'
                }else{
                    flash.message = message(code:'user.profile.update.fail')
                    flash.css = 'error'
                }            
            }else{
                flash.message = message(code:'user.profile.update.password_not_match')
                flash.css = 'info'
            }
        }else{
            if(user.save(flush:true)){
                flash.message = message(code:'user.profile.update.success')
                flash.css = 'info'
            }else{
                flash.message = message(code:'user.profile.update.fail')
                flash.css = 'error'
            }
        }        
        redirect(action: 'editProfile')
    }
}
