include: "rules/common_preprocessing/making_sample_dataset.rules"

rule all:
    input:
        #QC
        "QC/multiqc_raw_reads_report.html",
        #"QC/multiqc_DADA2_filtered_reads_report.html",

        #DADA2
        expand("{denoiser}/2_denoised/dna-sequences.fasta", denoiser = config["denoiser"]),
        expand("{denoiser}/2_denoised/count-table.qzv", denoiser = config["denoiser"]),
        expand("{denoiser}/2_denoised/rep-seqs.qzv", denoiser = config["denoiser"]),
        #expand("{denoiser}/2_denoised/DADA2_denoising_stats.tsv", denoiser = config["denoiser"]),
        expand("{denoiser}/3_classified/rdp/{tax_DB}/dna-sequences_tax_assignments.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"]),

        #rarefied
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/rarefaction_{rarefaction_value}/alpha_diversity/{grouping_column}_alpha_divesity.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"], grouping_column=list(set(all_samples[config["grouping_column"]])), rarefaction_value=config["rarefaction_value"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/rarefaction_{rarefaction_value}/ordination/{grouping_column}_{ordination_distance}.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"],grouping_column=list(set(all_samples[config["grouping_column"]])), rarefaction_value=config["rarefaction_value"], ordination_distance = config["ordination_distance"]),
        #expand("{denoiser}/5_visualization/rdp/{tax_DB}/rarefaction_{rarefaction_value}/rarefaction_curve.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"], rarefaction_value=config["rarefaction_value"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/rarefaction_{rarefaction_value}/KRONA/{grouping_column}.html", denoiser = config["denoiser"], tax_DB = config["tax_DB"], grouping_column=list(set(all_samples[config["grouping_column"]])), rarefaction_value=config["rarefaction_value"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/rarefaction_{rarefaction_value}/physeq/collap_{collapse_level}/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}_featuresfilt_melted.tsv",  denoiser = config["denoiser"], tax_DB = config["tax_DB"], rarefaction_value=config["rarefaction_value"], column_value = config["column_value"], meta_column = config["meta_column"], filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"] , collapse_level = config["collapse_level"]),

        #notrarefied
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/reads/reads_plot_with_filtered.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/KRONA/{grouping_column}.html", denoiser = config["denoiser"], tax_DB = config["tax_DB"], grouping_column=list(set(all_samples[config["grouping_column"]]))),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/alpha_diversity/{grouping_column}_alpha_divesity.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"], grouping_column=list(set(all_samples[config["grouping_column"]]))),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/ordination/{grouping_column}_{ordination_distance}.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"], grouping_column=list(set(all_samples[config["grouping_column"]])), ordination_distance = config["ordination_distance"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/rarefaction_curve.png", denoiser = config["denoiser"], tax_DB = config["tax_DB"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/physeq/no_collapse/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}_featuresfilt_melted.tsv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], column_value = config["column_value"], meta_column = config["meta_column"], filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/physeq/collap_{collapse_level}/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}_featuresfilt_melted.tsv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], column_value = config["column_value"], meta_column = config["meta_column"], filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"] , collapse_level = config["collapse_level"]),


        #ANCOM
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/ANCOM/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}_f_{tested_factor}.qzv",  denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),

        #Gneiss correlation based
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/Gneiss/correlation/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/hier_correlation_regression.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/Gneiss/correlation/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/hier_correlation_heatmap_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/Gneiss/correlation/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/hier_correlation_y_{y_balances}_f_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/no_collapse/Gneiss/correlation/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/hier_correlation_regression.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/no_collapse/Gneiss/correlation/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/hier_correlation_heatmap_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/no_collapse/Gneiss/correlation/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/hier_correlation_y_{y_balances}_f_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),


        #Gneiss phylogeny based
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/Gneiss/phylogeny/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/phyl_phylogenetic_regression.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/Gneiss/phylogeny/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/phyl_phylogenetic_heatmap_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/collap_{collapse_level}/Gneiss/phylogeny/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/phyl_phylogenetic_y_{y_balances}_f_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/physeq/collap_{collapse_level}/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}_featuresfilt/count-table.qzv",  denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/no_collapse/Gneiss/phylogeny/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/phyl_phylogenetic_regression.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/no_collapse/Gneiss/phylogeny/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/phyl_phylogenetic_heatmap_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/diff_abundance/no_collapse/Gneiss/phylogeny/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}/phyl_phylogenetic_y_{y_balances}_f_{tested_factor}.qzv", denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"]),
        expand("{denoiser}/5_visualization/rdp/{tax_DB}/norarefaction/physeq/no_collapse/{filter_tax_rank}_{filter_lineage}_taxfilt_{column_value}_in_{meta_column}_featuresfilt/count-table.qzv",  denoiser = config["denoiser"], tax_DB = config["tax_DB"], collapse_level = config["collapse_level"], tested_factor= config["ANCOM_factors"], y_balances = list(range(1, 9)), filter_tax_rank = config["filter_tax_rank"], filter_lineage = config["filter_lineage"], column_value = config["column_value"], meta_column = config["meta_column"])

        #Gneiss gradient based to be implemented


include: "rules/common_preprocessing/get_reads.rules"
include: "rules/common_preprocessing/get_sras.rules"
include: "rules/common_preprocessing/QC_raw_reads.rules"
include: "rules/DADA2_ASV/cutadapt_trim.rules"
include: "rules/DADA2_ASV/DADA2_denoising.rules"
include: "rules/DADA2_ASV/QC_DADA2.rules"
include: "rules/vsearch_OTU/PANDAseq_trim_filter_pair.rules"
include: "rules/vsearch_OTU/vsearch_derep_and_clustering.rules"
include: "rules/vsearch_OTU/vsearch_count_tables_and_reformat.rules"
include: "rules/common_tax_assignment/RDP_in_QIIME.rules"
include: "rules/common_tax_tree/tree.rules"
include: "rules/common_visualization/Import_to_QIIME2.rules"
include: "rules/common_visualization/Phyloseq.rules"
include: "rules/common_visualization/General_plotting.rules"
include: "rules/common_visualization/Qiime2_stat_analysis_phyloseq_preprocessing.rules"
