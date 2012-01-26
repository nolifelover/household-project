package com.core

class CommonService {

    static transactional = true

    def monthFormat(month, format = null) {
        def output = ""
        def locale = new Locale("en","US")
        def thaiLocale = new Locale("th", "TH")
        try{
            def parseDate = month
            if(!(parseDate instanceof java.util.Date)){
                //println "not date $parseDate"
                parseDate = new java.text.SimpleDateFormat("MM/yy", locale).parse(month)
                //println "parse $parseDate"
            }
            if(!format){
                format = "MMMM yyyy"
            }
            def date = new java.text.SimpleDateFormat(format, thaiLocale).format(parseDate)
            output+=date
        }catch (Exception e){
            
        }
        return output
    }
    
    def historyFormat(histories) {
        histories.each{ history ->
            history.displayMonth = "'${this.monthFormat(history.month)}'"
            history.outcomeAbs = history.outcome.abs()
            history.incomeAbs = history.income.abs()
            history.balance = history.income + history.outcome
            history.sortMonth = this.monthFormat(history.month, "yyyy-MM")
        }
        histories.sort{it.sortMonth}
    }
    
    def pieFormat(mainCategories, values, limit = 6){
        def results = []
        mainCategories.each{ main ->
            def categories = main.sortCategories
            categories.each{ category ->
                def index = category.id
                def name = "$category.name"
                def value = values["$index"]
                def map = [name: name, value: value]
                results << map
            }
        }
        
        results = results.sort{ it.value?.abs() }.reverse()
        
        def series = ""
        def index = 1
        def otherCategory = 0.0
        results.each{ result ->
            def value = result.value
            log.debug "value => $value"
            if(index > limit && value){
                otherCategory = otherCategory + value
            }else{
                def message = result.name
                if(message.size() > 20){
                    message = result.name[0..20] + ".."
                }
                series += "['$message',$value],"
                index++
            }            
        }

        if(otherCategory != 0){
            series += "['อื่นๆ', $otherCategory],"
        }
        log.debug "$series"
        series = "["+series+"]"        
    }
}
