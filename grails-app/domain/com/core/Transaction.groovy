package com.core

class Transaction {
    Double amount
    Integer paymentMethod
    Date onDate
    Date dateCreated
    Date lastUpdated
    String month
    static belongsTo = [category:Category, account:Account]
    static constraints = {
        onDate(nullable:true, blank:true)
    }
    static mapping = {
        autoTimestamp true        
    }
    
    static def findAmount(account, category, month){
        try{
            def transaction = Transaction.findByAccountAndCategoryAndMonth(account, category, month)
            if(transaction){
                return transaction.amount
            }else{
                return "-"
            }            
        }catch(Exception e){
            return "-"
        }        
    }
}
