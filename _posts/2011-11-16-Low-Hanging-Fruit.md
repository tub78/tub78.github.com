---
layout: default
title: Low Hanging Fruit
---


<!--
Title: Low-Hanging-Fruit
Timestamp: 2011-11-09 20:08:37 +0000
Created: 2011-11-09 20:08:37 +0000
Last Accessed: 2011-11-09 20:08:37 +0000
Times Accessed: 1
Tags: Gene, Genomics, Biology, Rstats, Ttest
Metadata: 
-->

>%hdrrelated%
># Related
> * [[Genomics]]
> * [[Gene Expression]]
> * [[Student's t-test]]
> * [[Student's t-distribution]]
> * [[P-value]]
> * [[Multiple comparisons]]
> * [[False Discovery Rate]]

[Genomics]: http://en.wikipedia.org/wiki/Genomics
[Gene Expression]: http://en.wikipedia.org/wiki/Gene_Expression
[Student's t-test]: http://en.wikipedia.org/wiki/Student\%27s_t-test
[Student's t-distribution]: http://en.wikipedia.org/wiki/Student\%27s_t-distribution
[P-value]: http://en.wikipedia.org/wiki/P-value
[Multiple comparisons]: http://en.wikipedia.org/wiki/Multiple_comparisons
[False Discovery Rate]: http://en.wikipedia.org/wiki/False_Discovery_Rate


<!--
[sim.t.test.density-p-value-p1.jpg]: http://lh3.ggpht.com/-AHYz5NXycB0/TsRmvcFx40I/AAAAAAAABLE/i-OFk4ttoMc/sim.t.test.density-p-value-p1.jpg =340x "Figure 1"
[sim.t.test.density-p-value-p2.jpg]: http://lh5.ggpht.com/-wJop5cKhbjo/TsRmwHgEGII/AAAAAAAABLI/dnim9avBhAE/sim.t.test.density-p-value-p2.jpg =340x "Figure 2"
[sim.t.test.density-p-value-p3.jpg]: http://lh3.ggpht.com/-uSfKnS_-WRQ/TsRmwxz7EBI/AAAAAAAABLM/yKqLXcC4RwI/sim.t.test.density-p-value-p3.jpg =340x "Figure 3"
[sim.t.test.density-p-value-p4.jpg]: http://lh4.ggpht.com/-OY15_MfRzdE/TsRmxXjKp0I/AAAAAAAABLQ/_EF_TaGBlyw/sim.t.test.density-p-value-p4.jpg =340x "Figure 4"
# Low-Hanging Fruit
-->

A central problem in genomics is the identification of the molecular machinery that is responsible for the phenotype, the set of all observable characteristics, of an organism.  One of the more informative sources of evidence is _gene expression_, which is the abundance of molecules that a gene produces in a given context.  The advent of high-throughput technologies and related statistical methods provide a means to pick the most probable candidate genes - the "low-hanging fruit" - that determine phenotype.

1. High-throughput technologies enable measurement of the _differential expression_ (DE) between two groups or conditions for a large collection of genes, and 
1. Statistical methods, known as false discovery rate (FDR) correction, help to determine which of the measured differences are truly significant.  These methods play an important role in cost-benefit analysis when deciding how many potential DE genes to select for validation.

<!-- This post examines the behaviour of **p-values** and the **false discovery rate (FDR)** for small samples. -->

In the following, a simulation study involving randomly generated _gene expressions_ for a large number of genes is used to analyze the behaviour of _p-values_ and the influence of _false discovery rate (FDR) correction_ with small sample sizes.


# Hypothesis Testing

Hypothesis testing is used to decide whether an observed DE gene occured by chance ("the null"), or constitutes evidence of an underlying biological effect ("the alternative").  The p-value for a hypothesis test is the chance of observing measurements as extreme as found in the experiment under the assumption that there is no difference in the two conditions.  It is closely related, but not necessarily equal, to the probability of false discovery, which is the probability that the gene is falsely classified as DE.

Suppose there are [](raw:\( N \)) samples each from conditions [](raw:\( A \)) and [](raw:\( B \)).  The magnitude of DE is the difference between the two means, [](raw:\( \bar{x}_A-\bar{x}_B \)).  If the samples are independent, normally-distributed, and the variances of the two groups are the same, then a suitable test is the T-test.  A t-statistic is calculated as [ttest]

[ttest]: raw:\[T =  \frac{\bar{x}_B - \bar{x}_A}{s\sqrt{2/N}}\]

where [](raw:\( s \)) is the pooled estimate of the standard deviation.  Under the assumptions of the test, the value [](raw:\( T\, \)) follows a Student's t-distribution, with [](raw:\( d = 2 * N - 2 \)) degrees of freedom.  The p-value for the 2-sided T-test is computed as [pval-eqn]

[pval-eqn]: raw:\[ p = 1 - P\left( -|T| < t < |T| \right) . \]

If the p-value is less than the level-of-significance [](raw:\( \alpha \)), then the null hypothesis is rejected, and the observed DE is significant at that [](raw:\( \alpha \))-significance level.

## Example

Suppose there are [](raw:\( N=4 \)) samples, each, from both conditions with the following gene expression values:  [](raw:\( A = \left\{ 2, 4, 1, 1 \right\} \)) and [](raw:\( B = \left\{ 9, 11, 10, 7 \right\} \)).  The t-statistic is calculated as [ttest-eg] where [](raw:\( s \approx 4.14\,\)) is the pooled estimate of the standard deviation.  Using the lookup table on [Student's t-distribution], the p-value for this 2-sided test is [](raw:\( p < 0.05 \)) supporting the conclusion that significant DE was observed.

[ttest-eg]: raw:\[T = \frac{(9 + 11 + 10 + 7)/4 - (2 + 4 + 1 + 1)/4}{s \sqrt{2 / 4}} \approx 2.478\,,\]

<!-- x = np.array([[2,4,1,1],[9,11,10,7]]); np.diff(np.mean(x, axis=1))*sqrt(2)/(np.std(x, ddof=1)) -->

# False Discovery Rate Correction

When testing a large number of genes, a threshold based on the p-value fails to meaningfully convey the significance of the resulting list of genes because it does not take into account the elevated chance of observing extreme levels of differential expression through repeated, independent trials.  So, for example, while it is unusual to observe a p-value of 0.01 in a single experiment, it is nevertheless expected that such small p-values will be observed with regularity as more and more genes are tested. 

In order to provide a meaningful measure of significance, methods have been developed to estimate the false discovery rate for the top-k most DE genes.  For example, the Benjamini-Hochberg–Yekutieli (BH) method estimates the FDR to be the minimum [](raw:\( q_k \)) such that [qval-eqn] where [](raw:\( p_i \)) is the [](raw:\( i \))-th smallest p-value, and [](raw:\( m \)) is the number of genes tested.  The value [](raw:\( q_k \)) for [](raw:\( k = 1, \ldots, m \)), associated with the gene at rank k, is referred to as the FDR-corrected p-value.

[qval-eqn]: raw:\[ p_i \leq \frac{i}{m} q_k, \quad \forall i\leq k \,. \]


# Genomics Simulation

A simulation study involving randomly generated gene expressions for a large number of genes is used to analyze the behaviour of _p-values_ and the influence of _false discovery rate (FDR) correction_ with small sample sizes.  This setting was chosen to resemble the genomics context.  Specifically, a large number of genes are simultaneously screened for differential expression between groups, using only a small number of samples.

1. Each data set, numbered by [](raw:\( i = 1, \ldots, 2000 \)), is comprised of [](raw:\( N \)) randomly generated samples from each of two groups [](raw:\( A_i \)) and [](raw:\( B_i \)).
1. Samples are assumed to be normally-distributed: [](raw:\( A_i \))'s samples have mean [](raw:\( \mu_i \)), [](raw:\( B_i \))'s samples have mean [](raw:\( \nu_i \)), and both have variance [](raw:\( \sigma_i^2 = 1 \)).
1. With fixed values of the free parameters: [](raw:\( N \)) , [](raw:\( \mu_i \)) , and [](raw:\( \nu_i \)), a p-value is calculated as above for each comparison, giving rise to a distribution across all 2000 tests.
 
In the figures below, the shape and variability of the distribution of p-values is analyzed.  Each figure contains three curves corresponding to data sets of varying size: red([](raw:\( N=3 \)) ), green([](raw:\( N=5 \)) ), and blue([](raw:\( N=7 \)) ).  Due to the procedure used for density estimation, the displayed curves extend beyond the unit interval, despite the fact that p-values are bounded [](raw:\( 0 \leq p_i \leq 1 \)).  While in common practice there will be a mixture of: 1) DE, and 2) non-DE genes in a single experiment, these two cases are treated separately for clarity.

## DE & Non-DE Genes Without FDR Correction

Figure 1 shows the distribution of p-values when the groups are differentially expressed, with [](raw:\( \mu_i = 0 \)) and [](raw:\( \nu_i = 1 \)) for all [](raw:\( i \)) .  By design, a large proportion of p-values are close to zero, and for [](raw:\( N \geq 7 \)),  below the commonly-used [](raw:\( \alpha = 0.05 \)) level-of-significance.  However, each distribution has a long tail that extends toward [](raw:\( p_i = 1 \)).  This effect is most pronounced for [](raw:\( N=3 \)), which is a reflection of the diminishing power of the T-test as [](raw:\( N \)) decreases.  Thus, for [](raw:\( N \geq 7 \)), it is relatively easy to detect differential expression.

> %justcenter%
> ![sim.t.test.density-p-value-p1.jpg][]
>
> Figure 1
>
> ![sim.t.test.density-p-value-p2.jpg][]
>
> Figure 2

Figure 2 shows the distribution of p-values when groups [](raw:\( A_i \)) and [](raw:\( B_i \)) have the same mean [](raw:\( \mu_i = \nu_i \)) for all [](raw:\( i \)), and so are not differentially expressed.  The p-values are approximately uniformly distributed, in accordance with a classical result in statistics.  Roughly speaking, since under the null-hypothesis (non-DE) the test statistic follows a Student's-t distribution, the p-value is obtained from its cumulative distribution function, and is therefore uniform.  See [[here][here1]], [[here][here2]], and [[here][here3]] for details.

The take-home message of this simulation is that one observes [](raw:\( p_i \leq 0.05 \)) about 5% of the time for genes that are not differentially expressed.  This result demonstrates why statistical methods have been developed to compensate for false positives in multiple testing scenarios.

[here1]: http://stats.stackexchange.com/questions/10613/why-p-values-are-uniformly-distributed
[here2]: http://en.wikipedia.org/wiki/Probability_integral_transform
[here3]: http://pubs.amstat.org/doi/abs/10.1198/000313008X332421


## DE & Non-DE Genes With FDR Correction

Figures 3 and 4 show the effect of FDR-correction on the distributions of p-values from Figures 1 and 2, respectively.  Again, each figure contains three curves corresponding to data sets of varying size: red([](raw:\( N=3 \)) ), green([](raw:\( N=5 \)) ), and blue([](raw:\( N=7 \)) ).  The dominant effect is that each distribution has been shifted toward [](raw:\( p=1 \)), lowering the estimated likelihood of discovery for each associated gene. 

For example, for [](raw:\( N=3 \)) in Figure 3, the red curve shows an estimated false discovery rate of between 10-20% amongst the first selected DE genes.  Fortunately, as shown in Figure 4, non-DE genes are assigned FDR-corrected p-values close to 1 thereby diminishing the chance that these genes will be selected. 

> %justcenter%
> ![sim.t.test.density-p-value-p3.jpg][]
>
> Figure 3
>
> ![sim.t.test.density-p-value-p4.jpg][]
>
> Figure 4

Caveat 
: In practice, FDR-correction is applied to the mixture of p-values from DE and non-DE genes.  Figures 3 and 4 do not accurately represent the behaviour of FDR-correction on this mixture, because each corrected p-value depends on the input collection to which it belongs.  A more informative result could be obtained by performing FDR-correction on the entire set of simulated genes, DE and non-DE, before segregating and plotting.


# Summary

This post analyzed the behaviour of p-values and the influence of FDR-correction in a simulation study with many genes but only a few samples from each group.  Simulation studies such as this one are useful for illuminating the cost-benefit trade-offs encountered in the search for molecular determinants of phenotype with high-throughput screening.



