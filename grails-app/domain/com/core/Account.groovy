package com.core

class Account {
    String code
    String province
    String district
    String tumbon
    String moo
    String householder
    Integer familyNumber
    static hasMany = [transactions: Transaction]
    static constraints = {
    }
    
    def history(){
        def transactions = this.transactions
        def results = []
        transactions.each{ t->
            def map = results.find { it.month == t.month }
            //log.debug "map => $map"
            if(!map){
                map = [month:"${t.month}", income: 0, outcome: 0]
                results << map
            }
            if(t.paymentMethod == 1){
                map.income = map.income + t.amount
            }else{
                map.outcome = map.outcome + t.amount
            }
        }        
        results
    }
    
    static def getMoos(tumbon, district, province, max = 50){
        def moosInstances = []
        def accountInstances = Account.withCriteria(){
            if(province){
                like("provice", "${province}%")
            }
            
            if(district){
                like("district", "${district}%")
            }
            
            if(tumbon){
                like("tumbon", "${tumbon}%")
            }
            
            maxResults(max)
        }
        
        accountInstances.each{ account ->
            def map = moosInstances.find { (it.province == account.province && it.district == account.district && it.tumbon == account.tumbon && it.moo == account.moo ) }
            //log.debug "map => $map"
            if(!map){
                map = [province: account.province, district: account.district, tumbon: account.tumbon, moo: account.moo]
                moosInstances << map
            }
        }
        moosInstances
    }
    
    static def mooHistory(moo, tumbon, district, province){
        def results = []
        def accountInstances = Account.withCriteria(){
            if(province){
                eq("province", "${province}")
            }
            
            if(district){
                eq("district", "${district}")
            }
            
            if(tumbon){
                eq("tumbon", "${tumbon}")
            }
            
            if(moo){
                eq("moo", "${moo}")
            }
        }
        
        accountInstances.each{ account->
            account.transactions.each{ t->
                def map = results.find { it.month == t.month }
                //log.debug "map => $map"
                if(!map){
                    map = [month:t.month, income: 0, outcome: 0]
                    results << map
                }
                if(t.paymentMethod == 1){
                    map.income = map.income + t.amount
                }else{
                    map.outcome = map.outcome + t.amount
                }
            }
        }        
        results
    }
    
    static def mooDetail(month, moo, tumbon, district, province){
        def accountInstances = Account.withCriteria(){
            if(province){
                eq("province", "${province}")
            }
            
            if(district){
                eq("district", "${district}")
            }
            
            if(tumbon){
                eq("tumbon", "${tumbon}")
            }
            
            if(moo){
                eq("moo", "${moo}")
            }
        }
        
        def result = [accounts: accountInstances]

        def transactions = Transaction.withCriteria(){
            'in'('account', accountInstances)
            eq('month', month)
        }
        
        //has 2 attibutes amount, category
        def virtualTransactions = []
        transactions.each{ t->
            def virtual = virtualTransactions.find { it.category == t.category }
            if(!virtual){
                virtual = [amount: t.amount, category: t.category]
                virtualTransactions << virtual
            }else{
                virtual.amount = virtual.amount + t.amount
            }            
        }
        result.transactions = virtualTransactions
        
        result
    }
    
    
    static def getTumbons(district, province, max = 50){
        def tumbonsInstances = []
        def accountInstances = Account.withCriteria(){
            if(province){
                like("provice", "${province}%")
            }
            
            if(district){
                like("district", "${district}%")
            }
            
            maxResults(max)
        }
        
        accountInstances.each{ account ->
            def map = tumbonsInstances.find { (it.province == account.province && it.district == account.district && it.tumbon == account.tumbon) }
            //log.debug "map => $map"
            if(!map){
                map = [province: account.province, district: account.district, tumbon: account.tumbon]
                tumbonsInstances << map
            }
        }
        tumbonsInstances
    }
    
    static def tumbonHistory(tumbon, district, province){
        def results = []
        def accountInstances = Account.withCriteria(){
            if(province){
                eq("province", "${province}")
            }
            
            if(district){
                eq("district", "${district}")
            }
            
            if(tumbon){
                eq("tumbon", "${tumbon}")
            }
        }
        
        accountInstances.each{ account->
            account.transactions.each{ t->
                def map = results.find { it.month == t.month }
                //log.debug "map => $map"
                if(!map){
                    map = [month:t.month, income: 0, outcome: 0]
                    results << map
                }
                if(t.paymentMethod == 1){
                    map.income = map.income + t.amount
                }else{
                    map.outcome = map.outcome + t.amount
                }
            }
        }        
        results
    }
    
    static def tumbonDetail(month, tumbon, district, province){
        def accountInstances = Account.withCriteria(){
            if(province){
                eq("province", "${province}")
            }
            
            if(district){
                eq("district", "${district}")
            }
            
            if(tumbon){
                eq("tumbon", "${tumbon}")
            }
        }
        
        def result = [accounts: accountInstances]

        def transactions = Transaction.withCriteria(){
            'in'('account', accountInstances)
            eq('month', month)
        }
        
        //has 2 attibutes amount, category
        def virtualTransactions = []
        transactions.each{ t->
            def virtual = virtualTransactions.find { it.category == t.category }
            if(!virtual){
                virtual = [amount: t.amount, category: t.category]
                virtualTransactions << virtual
            }else{
                virtual.amount = virtual.amount + t.amount
            }            
        }
        result.transactions = virtualTransactions
        
        result
    }
    
    static def compareHistory(category, moo, tumbon, district, province){
        def results = []
        def accountInstances = Account.withCriteria(){
            if(province){
                eq("province", "${province}")
            }
            
            if(district){
                eq("district", "${district}")
            }
            
            if(tumbon){
                eq("tumbon", "${tumbon}")
            }
            
            if(moo){
                eq("moo", "${moo}")
            }
        }
        
        def transactions = Transaction.withCriteria(){
            'in'('account', accountInstances)
            eq('category', category)
        }
        
        transactions.each{ t->
            def map = results.find { it.month == t.month }
            if(!map){
                map = [month:t.month, amount: t.amount]
                results << map
            }else{
                map.amount = map.amount + t.amount
            }
        }
        
        results
    }
}
