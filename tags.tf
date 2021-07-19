locals { 
  common_tags = { 
    environment     = "${lower(var.ENV)}" 
    project         = "jously" 
    managedby       = "allservices_techOps@jously.com"
  } 
} 
