package com.core

class Category {
    String name
    Integer position = 0
    static belongsTo = [mainCategory: MainCategory]
    static constraints = {
    }
    
    def paymentMethod(){
        def main = this.mainCategory
        return main.paymentMethod
    }
}
