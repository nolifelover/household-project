package com.core
import grails.converters.*
class IncomeController {
    def commonService
    def enFormat = new java.text.SimpleDateFormat("MM/yy", new java.util.Locale("en", "US"))
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
        def month = enFormat.format(new Date())
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, accountCode: params.code, month: month]
    }
    
    def saveAll = {
        log.debug "params => $params"
        if(params.code){
            def account = Account.findByCode(params.code)
            if(!account){
                flash.message = message(code:"income.create.not_found_code")
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
                        if(category.paymentMethod() == 2){
                            amount = 0 - (amount as Double)
                        }
                        def transaction = new Transaction(category:category, account:account, amount: (amount as Double), paymentMethod: category.paymentMethod(), month: month, onDate: now)
                        transaction.save(flush:true, failOnError:true)
                    }
                }
                flash.message = message(code:"income.create.successful")
                flash.css = "info"
                redirect(controller:"account", action: "index")
                return
            }
        }else{
            flash.message = message(code:"income.create.not_found_code")
            flash.css = "error"
            redirect(action: "createAll")
        }
    }
    
    def editAll = {
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
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, accountCode: accountInstance.code, month: month, values: values]
    }
    
    def updateAll = {
        log.debug "params => $params"
        if(params.code){
            def account = Account.findByCode(params.code)
            if(!account){
                flash.message = message(code: "income.update.not_found_code")
                flash.css = "error"
                redirect(controller: "account", action: "code", params:[id: account.code])
                return
            }else{
                def categories = Category.list()
                def month = params.month
                categories.each{category ->
                    def amount = params."category_${category.id}"
                    log.debug "category_${category.id} => $amount"
                    def now = new Date()
                    if(amount){
                        log.debug "before error => ${amount}"
                        amount = amount.toString() as Double
                        if(category.paymentMethod() == 2){
                            
                            if(amount > 0){
                                amount = 0 - amount
                            }                            
                        }
                        def transactions = Transaction.withCriteria(){
                            eq("category", category)
                            eq("account", account)
                            eq("month", month)
                        }
                        def transaction
                        if(transactions.size() >= 1){
                            transaction = transactions[0]
                            transaction.amount = amount
                        }else{
                            transaction = new Transaction(category:category, account:account, amount: (amount as Double), paymentMethod: category.paymentMethod(), month: month, onDate: now)
                        }
                        
                        transaction.save(flush:true, failOnError:true)
                    }
                }
                flash.message = message(code:"income.update.successful")
                flash.css = "info"
                redirect(controller: "account", action: "code", params:[id: params.code])
                return
            }
        }else{
            flash.message = message(code: "income.update.not_found_code")
            flash.css = "error"
            redirect(controller: "account", action: "code", params:[id: params.code])
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
        def avgs = [:]
        transactions.each{ t->
            values."${t.category.id}" = t.amount
            avgs."${t.category.id}" = t.amount/accountInstance.familyNumber
        }
        
        def displayMonth = commonService.monthFormat(month)
        
        def pieIncome = commonService.pieFormat(incomeInstances, values)
        def pieOutcome = commonService.pieFormat(outcomeInstances, values)
        
        //render pieIncome as JSON
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, month:month, accountInstance: accountInstance, values: values, avgs: avgs, pieIncome: pieIncome, pieOutcome: pieOutcome, displayMonth: displayMonth]
    }
}
