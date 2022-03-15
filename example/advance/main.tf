module "acr" {
    source = "../"
    resource_group_name = module.res_group.name
    
}