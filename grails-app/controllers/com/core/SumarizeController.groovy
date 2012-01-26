package com.core
import grails.converters.*
class SumarizeController {
    def commonService
    
    def index = { }
    
    def searchMoo = {
        
    }
    
    def searchMooInfo = {
        def max = Math.min(params.max ? params.max.toInteger() : 50,  100)
        def mooInstances = Account.getMoos(params.tumbon, params.district, params.province , max)
        //render moosInstances as JSON
        [mooInstances: mooInstances]
    }
    
    def mooAll = {
        def histories = Account.mooHistory(params.moo, params.tumbon, params.district, params.province)
        histories = commonService.historyFormat(histories)

        [histories: histories]        
    }
    
    def mooDetail = {
        def month = params.month
        def incomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 1)
        }
        
        def outcomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 2)
        }
        
        def result = Account.mooDetail(params.month, params.moo, params.tumbon, params.district, params.province)
        def transactions = result.transactions
        //render transactions as JSON
        
        
        def values = [:]
        def avgs = [:]
        transactions.each{ t->
            values."${t.category.id}" = t.amount
            avgs."${t.category.id}" = t.amount/result.accounts.size()
        }
        
        def pieIncome = commonService.pieFormat(incomeInstances, values)
        def pieOutcome = commonService.pieFormat(outcomeInstances, values)
        
        def displayMonth = commonService.monthFormat(month)
        
        log.debug "values => $values"
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, month:month, displayMonth: displayMonth, values: values, avgs: avgs, pieIncome: pieIncome, pieOutcome: pieOutcome]
        
    }
    
    def searchTumbon = {
        
    }
    
    def searchTumbonInfo = {
        def max = Math.min(params.max ? params.max.toInteger() : 50,  100)
        def tumbonInstances = Account.getTumbons(params.district, params.province , max)
        //render moosInstances as JSON
        [tumbonInstances: tumbonInstances]
    }
    
    def tumbonAll = {
        def histories = Account.tumbonHistory(params.tumbon, params.district, params.province)
        histories = commonService.historyFormat(histories)

        [histories: histories]        
    }
    
    def tumbonDetail = {
        def month = params.month
        def incomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 1)
        }
        
        def outcomeInstances = MainCategory.withCriteria(){
            eq("paymentMethod", 2)
        }
        
        def result = Account.tumbonDetail(params.month, params.tumbon, params.district, params.province)
        def transactions = result.transactions
        //render transactions as JSON
        
        
        def values = [:]
        def avgs = [:]
        transactions.each{ t->
            values."${t.category.id}" = t.amount
            avgs."${t.category.id}" = t.amount/result.accounts.size()
        }
        
        def pieIncome = commonService.pieFormat(incomeInstances, values)
        def pieOutcome = commonService.pieFormat(outcomeInstances, values)
        
        def displayMonth = commonService.monthFormat(month)
        
        log.debug "values => $values"
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, month:month, displayMonth: displayMonth, values: values, avgs: avgs, pieIncome: pieIncome, pieOutcome: pieOutcome]
        
    }
}
