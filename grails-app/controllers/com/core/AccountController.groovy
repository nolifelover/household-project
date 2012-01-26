package com.core

class AccountController {
    def commonService
    def index = {
        params.max = Math.min(params.max ? params.max.toInteger() : 50,  100)
        [accountsInstances: Account.list(params), accountTotalInstance: Account.count()]
    }
    
    def search = {}
    
    def searchInfo = {
        def max = Math.min(params.max ? params.max.toInteger() : 50,  100)
        def query = "$params.q%"
        def accountsInstance = Account.findAll("from Account as a where code like :query or householder like :query",[query: query],[max: max])
        [accountsInstance: accountsInstance]
    }
    
    def create = {
        def accountInstance = new Account()
        [accountInstance: accountInstance]
    }
    
    def code = {
        def accountInstance = Account.findByCode(params.id)
        if(!accountInstance){
            flash.message = "account.code.not_found"
            flash.css = "error"
            redirect(action: "index")
            return
        }
        def histories = commonService.historyFormat(accountInstance.history())
        
        [accountInstance: accountInstance, histories: histories]        
    }

    def save = {
        def accountInstance = new Account(params)
        if(accountInstance.save(flush: true)) {
            flash.message = message(code:"accout.save.success")
            flash.css = "info"
            redirect(action: "index")
        }
        else {
            render(view: "create", model: [accountInstance: accountInstance])
        }
    }
}
