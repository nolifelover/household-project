package com.core

class MainCategory {
    String name
    Integer paymentMethod
    Integer position = 0
    static hasMany = [categories: Category]
    static transients = ["sortCategories", "incomes", "outcomes"]
    static constraints = {
    }
    
    def getSortCategories(){
        def categories = Category.withCriteria(){
            eq("mainCategory", this)
            order("position", "asc")
        }
        return categories
    }
    
    static def getIncomes(){
        MainCategory.withCriteria(){
            eq("paymentMethod", 1)
        }
    }
    
    static def getOutComes(){
        MainCategory.withCriteria(){
            eq("paymentMethod", 2)
        }
    }
    
    static def collectCategories(){
        def mainCategories = MainCategory.withCriteria(){
            order("position", "asc")
            order("position", "asc")
        }
        def collections = []
        mainCategories.each{ main->
            def categories = main.getSortCategories()
            categories.each{category ->
                def map = [category: category, name: "${main.position}.${category.position}.${category.name}", value: category.id]
                collections << map
            }
        }
        
        collections
    }
}
