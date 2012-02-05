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
        def moos = [:]
        def mooSize = Account.getMoos(params.tumbon, params.district, params.province).size()
        transactions.each{ t->
            values."${t.category.id}" = t.amount
            avgs."${t.category.id}" = t.amount / result.accounts.size()
            moos."${t.category.id}" = t.amount / mooSize
        }
        
        def pieIncome = commonService.pieFormat(incomeInstances, values)
        def pieOutcome = commonService.pieFormat(outcomeInstances, values)
        
        def displayMonth = commonService.monthFormat(month)
        
        log.debug "values => $values"
        [incomeInstances: incomeInstances, outcomeInstances: outcomeInstances, month:month, displayMonth: displayMonth, values: values, avgs: avgs, moos: moos, pieIncome: pieIncome, pieOutcome: pieOutcome]
        
    }
    
    def compare = {
        def collections = MainCategory.collectCategories()
        def isMoo = false
        if(params.moo){
            isMoo = true
        }
        [isMoo: isMoo, categories: collections]
    }
    
    def doCompare = {
        def category = Category.get(params.category)
        def histories = Account.compareHistory(category, params.moo, params.tumbon, params.district, params.province)
        histories = commonService.compareFormat(histories)
        def displayCategory = "${category?.mainCategory?.position}.${category.position} ${category.name}"
        def isMoo = false
        if(params.moo){
            isMoo = true
        }
        [isMoo: isMoo, histories: histories, displayCategory: displayCategory]  
    }
}
