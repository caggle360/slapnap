# define variable groups for importance

# function to set a variable group
get_variable_group <- function(pred_names, hxb2_sites) {
    # get only the sites from the pred_names vector
    aa_positions <- unlist(lapply(strsplit(pred_names, ".", fixed = TRUE), function(x) x[2]))

    # get the ones matching the input sites
    site_character_vars <- pred_names[aa_positions %in% hxb2_sites]
    return(site_character_vars)
}

get_variable_groups <- function(data, pred_names) {
    # set up sites
    # CD4bs is feature group 2 from VRC01 paper plus additional sites identified by Adam
    gp120_cd4bs <- unique(c(c(124, 125, 126, 127, 196, 198, 279, 280, 281, 282, 283, 365, 366, 367, 368, 369, 370, 374, 425, 426, 427, 428, 429, 430, 431, 432, 455, 456, 457, 458, 459, 460, 461, 469, 471, 472, 473, 474, 475, 476, 477), c(197, 209, 279, 326, 369, 119, 120, 182, 204, 206, 207, 274, 304, 318, 369, 471), c(62, 64, 66, 207), c(61, 64, 197, 276, 362, 363, 386, 392, 462, 463)))
    gp120_v2_v2g_v2apex <- unique(c(157:196, c(121, 123, 124, 127, 197, 202, 203, 312, 315)))
    gp120_v3_v3g <- unique(c(296:334), c(380, 406, 408, 415, 419, 428, 441, 443, 471), c(156, 137))
    gp41_mper <- c(656:684, 609)

    # get all variable groups
    aa_gp120_cd4bs_vars <- get_variable_group(pred_names, gp120_cd4bs)
    aa_gp120_v2_vars <- get_variable_group(pred_names, gp120_v2_v2g_v2apex)
    aa_gp120_v3_vars <- get_variable_group(pred_names, gp120_v3_v3g)
    aa_gp41_mper_vars <- get_variable_group(pred_names, gp41_mper)
    aa_glyco_vars <- pred_names[grepl("sequons", pred_names)]
    aa_cysteine_vars <- pred_names[grepl("cysteine", pred_names)]
    aa_geometry_vars <- pred_names[grepl("length", pred_names)]
    return(list(gp120_cd4bs = aa_gp120_cd4bs_vars, gp120_v2 = aa_gp120_v2_vars,
                gp120_v3 = aa_gp120_v3_vars, gp41_mper = aa_gp41_mper_vars,
                glyco = aa_glyco_vars, cysteines = aa_cysteine_vars,
                geometry = aa_geometry_vars))
}

# get individual intrinsic importance groups
# @param pred_names the variable names to use
# @param ind_importance_type the type of individual importance
get_individual_features <- function(pred_names, ind_importance_type) {
    if (grepl("site", ind_importance_type)) {
        no_hxb2 <- gsub(".1mer", "", gsub("hxb2.", "", pred_names))
        non_site_vars <- pred_names[!grepl("hxb2", pred_names)]
        site_vars <- no_hxb2[grepl("hxb2", pred_names)]
        sites <- sort(as.numeric(unique(unlist(lapply(
            strsplit(site_vars, ".", fixed = TRUE),
            function(x) x[1]
        )))))
        site_lst <- sapply(
            1:length(sites),
            function(i) {
                pred_names[grepl(
                    paste0("hxb2.", sites[i], "."), pred_names, fixed = TRUE
                )]
            }, simplify = FALSE
        )
        lst <- c(as.list(non_site_vars), site_lst)
        names(lst) <- c(non_site_vars, paste0("hxb2_", sites))
    } else {
        lst <- as.list(pred_names)
        names(lst) <- pred_names
    }
    lst
}
