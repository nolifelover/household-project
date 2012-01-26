package com.core
import grails.converters.*
class IncomeController {
    def commonService
    
    def index = { }
    
    def create = {
        def transactionInstance = new Transaction()
        [transactionInstance: transactionInstance]
    }
    
    def save = {
        def transactionInstance = new Transaction(params)
        if(transactionInstance.save(flush: true)) {
            flash.message = message(code:"transaction.save.success")
            flash.css = "info"
            redirect(action: "index")
        }
        else {
            render(view: "create", model: [transactionInstance: transactionInstance])
        }
    }
    
    def createAll = {
        def incomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 1)
        }
        
        def outcomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 2)
        }
        def month = "01/12"
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, accountCode: params.code, month: month]
    }
    
    def saveAll = {
        log.debug "params => $params"
        if(params.code){
            def account = Account.findByCode(params.code)
            if(!account){
                flash.message = "income.create.not_found_code"
                flash.css = "error"
                redirect(action: "createAll")
                return
            }else{
                def categories = Category.list()
                def month = params.month
                categories.each{category ->
                    def amount = params."category_${category.id}"
                    log.debug "category_${category.id} => $amount"
                    def now = new Date()
                    if(amount){
                        def transaction = new Transaction(category:category, account:account, amount: (amount as Double), paymentMethod: category.paymentMethod(), month: month, onDate: now)
                        transaction.save(flush:true, failOnError:true)
                    }
                }
                flash.message = "income.create.successful"
                flash.css = "info"
                redirect(controller:"account", action: "index")
                return
            }
        }else{
            flash.message = "income.create.not_found_code"
            flash.css = "error"
            redirect(action: "createAll")
        }
    }
    
    def detail = {
        def accountInstance = Account.findByCode(params.id)
        def month = params.month
        def incomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 1)
        }
        
        def outcomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 2)
        }
        
        def transactions = Transaction.withCriteria(){
            eq('account', accountInstance)
            eq('month', month)
        }
        def values = [:]
        transactions.each{ t->
            values."${t.category.id}" = t.amount
        }
        
        def displayMonth = commonService.monthFormat(month)
        
        def pieIncome = commonService.pieFormat(incomeInstances, values)
        def pieOutcome = commonService.pieFormat(outcomeInstances, values)
        
        //render pieIncome as JSON
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, month:month, accountInstance: accountInstance, values: values, pieIncome: pieIncome, pieOutcome: pieOutcome, displayMonth: displayMonth]
    }
}
