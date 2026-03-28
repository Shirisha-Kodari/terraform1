variable "components" {
    default = {
        catalogue = {
            rule_priority = 10
        }
        user = {
            rule_priority = 20
        }
        cart = {          # this key 
                           
            rule_priority = 30 # this value
        }
        shipping = {
            rule_priority = 40
        }
        payment = {
            rule_priority = 50
        }
        frontend = { #listener 
            rule_priority = 10
        }
    }
}
    
    
  
