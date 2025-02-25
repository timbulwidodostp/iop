{smcl}
{* *! version 1.1.0 15sep2013}{...}
{cmd:help iop}{right: ({browse "http://www.stata-journal.com/article.html?article=st0361":SJ14-4: st0361})}
{hline}

{title:Title}

{p2colset 5 12 14 2}{...}
{p2col:{hi:iop} {hline 2}}Estimate ex-ante inequality of opportunity
{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 11 2}{cmd:iop}
{depvar} [{indepvars}] {ifin} {weight} [{cmd:,} {cmdab:d:etail}
{cmdab:s:hapley(}{it:stat}{cmd:)}
{cmdab:sgr:oup(}{it:str}{cmd:)} {cmdab:o:axaca}{it:(groupvar} {it:stat}{cmd:)}
{cmdab:t:ype(d}|{cmd:o}|{cmd:c)} {cmdab:l:ogit} {cmdab:boot:strap}{cmd:(}{it:int}{cmd:)}]

{pstd}{hi:fweight}s and {hi:iweight}s are allowed; see {help weight}.

{marker oldsyntax}{pstd}Syntax of version 1.0 (still working, but not recommended): 

{p 8 11 2}{cmd:iop}
{depvar} {indepvars} {ifin} [{cmd:,} {cmdab:boot:strap}{cmd:(}{it:int}{cmd:)}
{cmdab:decomp:osition}
{cmdab:gr:oups}{cmd:(}{it:varname}{cmd:)}
{cmdab:pr:opt}{cmd:(}{it:str}{cmd:)}
{cmdab:bootopt}{cmd:(}{it:str}{cmd:)}]


{title:Description}

{pstd} {cmd:iop} computes different measures of ex-ante inequality of
opportunity for continuous, binary, and ordered variables proposed in
the literature.  These methods are meant to explain how people's
circumstances affect their outcomes in ways they cannot control.  The
approach has two (sometimes three) steps:  {break}

{pstd} 1. The expected outcome, conditional on circumstances, is
computed.  All variation is exclusively due to circumstances.  This is
done by an ordinary least squares (OLS) or a probit, depending on the
type of variable. {break}

{pstd} 2. An inequality measure is applied to this conditional
expectation. {break}

{pstd} 3. Sometimes, in a third step, the inequality
measure is divided by the same inequality measure computed on the
original outcome in order to get a relative measure of inequality.

{phang} {marker fg1} {hi:{help iop##ref_fg1:Ferreira and Gignoux -- Continuous variables with inherent scale}}{p_end}{p 8 8 2}
(abbreviation: {cmd:fg1a} and {cmd:fg1r}) Ferreira and Gignoux (2011)
propose to first estimate an OLS regression of the continuous outcome
(positive values) on a set of circumstances.  The log mean deviation is
then applied to the predicted values (conditional expectation).  By
dividing this measure by the mean log deviation of the original outcome
variable, one obtains a relative measure of inequality of opportunity.
These measures are scale invariant but not translation invariant.

{phang}{marker fg2}{hi:{help iop##ref_fg2:Ferreira and Gignoux -- Continuous variables without inherent scale}}{p_end}{p 8 8 2} (abbreviation: {cmd:fg2r})
Ferreira and Gignoux (2014) propose a method very similar to Ferreira
and Gignoux (2011), but it is particularly suited for continuous
variables without inherent scale (for example, test scores).  For such
variables, a measure that is both translation and scale invariant is
needed.  They propose to use the relative measure only and to use it as an
inequality indicator of the variance.  The resulting relative inequality
of opportunity measure is equal to the R squared of a simple OLS
regression.  This measure is translation and scale invariant.

{phang}{marker pdb}{hi:{help iop##ref_pdb:Paes de Barros (2007) -- Dichotomous and ordered variables}}{p_end}{p 8 8 2} (abbreviation: {cmd:pdb}) Paes de Barros, de Carvalho, and Franco (2007) propose to
first estimate a probit on the dummy variable (for ordered variables, a
threshold must be chosen, and a dummy must be constructed).  The
predicted probability (conditional probability) is then used to compute
the dissimilarity index, which is an absolute measure of inequality of
opportunity.  The measure is scale invariant but not translation
invariant.

{phang}{marker ws}{hi:{help iop##ref_ws: Soloaga and Wendelspiess Cháavez Juárez (2013) -- Dichotomous and ordered variables}}{p_end}{p 8 8 2} (abbreviation: {cmd:ws}) This method is basically the same as the
one proposed by Paes de Barros, de Carvalho, and Franco (2007), except it uses a modified
dissimilarity index that is translation invariant but not scale
invariant.

    {ul:Abbrev}{col 8} {ul:Variable type}{col 29} {ul:Inequality measure}{col 60}{ul:Absolute} {col 72}{ul:Relative}
    {cmd:fg1*}   {col 8}cont.(with scale) {col 29}mean log deviation {col 60}yes {col 72}yes
    {cmd:fg2r}   {col 8}cont.(no scale)   {col 29}variance {col 60}no {col 72}yes
    {cmd:pdb}    {col 8}dummy/ordered     {col 29}dissimilarity index {col 60}yes {col 72}no
    {cmd:ws}     {col 8}dummy/ordered     {col 29}modified dissimilarity index {col 60}yes {col 72}no

{p 4 4 2}* = {cmd:fg1} is used for the method in general, while
{hi:fg1a} and {hi:fg1r} are used to distinguish the absolute and
the relative measure, respectively.{p_end} {p 4 4 2}Alternative commands are mentioned {help iop##alternatives:below}.{p_end}


{title:Options}

{phang}{cmdab:detail} makes the underlying regressions (OLS, probit, or
logit) visible.  By default, these regressions are not displayed.

{phang}{cmdab:shapley(}{it:stat}{hi:)} estimates the relative importance
of each circumstance variable.  The argument tells {cmd:iop} which
statistics to decompose.  The possible values depend on the type of variable.

        Type {col 30} Possible arguments
        {hline 42}
        Continuous {col 30} {cmd:fg1a}, {cmd:fg1r}, and {cmd:fg2r}
        Dummy/Ordered {col 30} {cmd:pdb} or {cmd:ws}
	{hline 42}	

{pmore}See {help iop##ref_fg1:Ferreira and Gignoux (2011)} for a
discussion on this issue.  The Shapley decomposition becomes very
computationally intensive when the number of circumstances increases.
Therefore, it is advisable to use this option with only a few
circumstance variables.

{phang}{cmdab:sgroup(}{it:str}{hi:)} allows the user to group some
circumstance variables in the computation of the Shapley value and
to reduce the number of computations required.  Grouping
variables makes particular sense when the variables are directly related (for
example, father's or mother's education) or when they are inseparable
(age and age squared).  To define the groups, the user has to indicate
the variable names and separate the groups by a comma.  For instance,
assume we have the 4 variables {cmd:x1}, {cmd:x2}, {cmd:z1}, and {cmd:z2}
and would like to group the {cmd:x} and {cmd:z} variables.  To do this,
we indicate {cmd:sgroups(x1 x2,z1 z2)}.  In this case, the computation
of the Shapley value requires only 2^2 = 4 instead of 2^4 = 16
estimations.  Note that grouping the variables affects the computation
of the Shapley value but does not affect the estimation of inequality of
opportunity.

{phang}{cmdab:oaxaca(}{it:groupvar stat}{hi:)} activates the Oaxaca-type
decomposition. The option takes two string arguments.  The argument
{it:groupvar} indicates the variable that contains the groups, and the
second argument indicates which statistics must be decomposed.  The
group variable must be numeric and can contain value labels for the
absolute measures of inequality of opportunity ({cmd:fg1a}, {cmd:pdb},
{cmd:ws}).  For the relative measures, such decomposition does not make
sense, because the difference might also be due to the total amount of
inequality.  By correcting for that, we would be back to the absolute
measure.  For ordered variables, the option {cmd:oaxaca()} is not
implemented, because it would yield an unmanageable amount of
decompositions.  In this case, a certain threshold should be chosen to
dichotomize the ordered variable, and the decomposition should be used
for only this threshold.

{phang}{cmdab:type}{cmd:(d}|{cmd:o}|{cmd:c)} specifies the variable type.
This option is optional because {cmd:iop} tries to figure the type of the
dependent variable on its own.  If {cmd:iop} fails to identify the type, you
can specify it with this option.  The possible values are {hi:d} (dummy
variables), {hi:o} (ordered variables), and {hi:c} (continuous variables).

{phang}{cmdab:logit} changes the model from the default probit to a logit
model.  This option is relevant only for dichotomous and ordered variables.

{phang}{cmdab:bootstrap}{cmd:(}{it:int}{cmd:)} allows the user to add
bootstrap standard errors to the point estimates.  The argument {it:int}
corresponds to the number of replications the user wants to estimate.
Obtaining the bootstrap standard errors can be computationally
intensive, so we suggest the users start with a relatively small
number of replications.


{phang}Options of the {help iop##oldsyntax:old syntax} (version
1.0)

{phang}{cmdab:bootstrap}{cmd:(}{it:int}{cmd:)} includes bootstrap
confidence intervals of the dissimilarity index by indicating the
desired amount of repetitions.  The default is {cmd:bootstrap(0)}, which
results in no computation of bootstrap confidence intervals.

{phang}{cmdab:decomposition} includes a decomposition of the computed
dissimilarity index.  The same method is used, and all but one variable is
set to the average when computing the predicted values.  Be aware that
the sum of these estimates does not necessarily yield the total effect.

{phang}{cmdab:groups}{cmd:(}{it:varname}{cmd:)} specifies that
decomposition is performed across groups.  It indicates the categorical
variable that contains a definition of the groups.

{phang}{cmdab:propt}{cmd:(}{it:str}{cmd:)} includes special options in
the probit estimation.  Write your probit options normally, and they will be
transmitted to the probit estimation in the script.

{phang}{cmdab:bootopt}{cmd:(}{it:str}{cmd:)} includes special options in
the bootstrap sampling.  Write your bootstrap options normally, and
they will be transmitted to the {cmd:bsample} command in the script.


{title:Estimating standard errors}

{pstd}We offer a built-in estimation for bootstrap standard errors. The
options are relatively limited, and we encourage users who would like to
change parameters of the bootstrap method to use the Stata command.  Look
at the {help iop##examples:last example} below to find out how you
can perform the bootstrap standard errors.  Moreover, we plan to include
analytical standard errors in {help iop##developments:future developments}.


{title:Examples}

{pstd}This example calculates the inequality of opportunity in 
access to schooling by using three explanatory variables: father's
education, family income, and a dummy for indigenous people.
Additionally, we perform a Shapley decomposition from the method of {help iop##pdb:Paes de Barros, de Carvalho, and Franco (2007)}.{p_end}
{phang2}{cmd:.iop} {cmd:access_school} {cmd:education_father} {cmd:family_income} {cmd:indigenous,} {cmd:shapley(pdb)}{p_end}

{pstd}This example performs the same estimation as the first example but
adds the Oaxaca-type decomposition by gender, which means that the
adapted dissimilarity index is computed for women and men individually
and for the counterfactual combinations.  For example, this is the
dissimilarity index of women if they had the estimated coefficients of
men or vice versa.{p_end}
{phang2}{cmd:.iop} {cmd:access_school} {cmd:education_father}
{cmd:family_income} {cmd:indigenous,} {cmd:oaxaca(gender ws)}

{pstd}This method estimates inequality of opportunity by income by using
the same three circumstances as in the first example.  The option
{cmd:detail} allows you to see the underlying OLS estimation as well.
Both methods proposed by Ferreira and Gignoux are applied.{p_end}
{phang2}{cmd:.iop} {cmd:income} {cmd:education_father} {cmd:family_income}
{cmd:indigenous,} {cmd:detail}

{pstd}This example estimates the same model as the example before, but
it computes the bootstrap standard errors in addition to the point
estimates for 200 replications. You should not perform the bootstrap
together with the Shapley decomposition or the Oaxaca-type decomposition
because this would be extremely computationally intensive.{p_end}
{phang2}{cmd:.iop} {cmd:income} {cmd:education_father} {cmd:family_income}
{cmd:indigenous,} {cmd:bootstrap(200)}


{title:Stored results}

{pstd}{cmd:iop} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(pdb)}}{cmd:pdb} measure{p_end}
{synopt:{cmd:r(ws)}}{cmd:ws} measure{p_end}
{synopt:{cmd:r(fg1a)}}{cmd:fg1a} measure{p_end}
{synopt:{cmd:r(fg1r)}}{cmd:fg1r} measure{p_end}
{synopt:{cmd:r(fg2r)}}{cmd:fg2r} measure{p_end}
{synopt:{cmd:r(pdbSD)}}bootstrap std. error of {cmd:pdb}{p_end}
{synopt:{cmd:r(wsSD)}}bootstrap std. error of {cmd:ws}{p_end}
{synopt:{cmd:r(fg1aSD)}}bootstrap std. error of {cmd:fg1a}{p_end}
{synopt:{cmd:r(fg1rSD)}}bootstrap std. error of {cmd:fg1r}{p_end}
{synopt:{cmd:r(fg2rSD)}}bootstrap std. error of {cmd:fg2r}{p_end}
{synopt:{cmd:r(bootN)}}number of bootstrap replications{p_end}

{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(iop)}}matrix with all inequality measures{p_end}
{synopt:{cmd:r(oaxaca)}}matrix of Oaxaca-type decomposition{p_end}


{title:Alternative commands}

{pstd} For binary variables, {helpb hoi} is an alternative command that
can be used to estimate the dissimilarity index.  {cmd:hoi} is different
from the previously discussed routine because it uses logit modeling to
estimate instead of probit modeling and because of the options the routine
offers to the user.  {cmd:hoi} should be preferred for inference because it
computes not only the bootstrap standard errors but also the analytical
standard errors.

{pstd}If we forgot to mention a command here, please let us know.


{title:Future developments}

{pstd}{cmd:iop} will be developed further.  If you have
suggestions, please let us know.  {break} We tested the routine extensively
before publication. However, we cannot exclude all errors.  We would appreciate
if you could inform us of remaining bugs in the program.

{pstd}To update the routine, type {cmd:scc install iop, replace}.


{title:References}

{phang}{marker ref_fg1} Ferreira, F. H. G., and J. Gignoux. 2011. The
measurement of inequality of opportunity: Theory and an application to
Latin America. {it: Review of Income and Wealth} 57: 622-657.

{phang}{marker ref_fg2}------. 2014.
The measurement of educational inequality:  Achievement and
opportunity.{it: World Bank Economic Review} 28: 210-246.

{phang}Paes de Barros, R., M. de Carvalho, and S. Franco. 2007.
Preliminary notes on the measurement of socially-determined inequality
of opportunity when the outcome is discrete. Working paper.

{phang}{marker ref_ws}Soloaga, I., and F. Wendelspiess Chávez Juárez. 2013.
Scale vs. translation invariant measures of inequality of opportunity when the
outcome is binary. {browse "http://iariw.org/c2013brazil.php"}.


{title:Authors}

{pstd}Florian Wendelspiess Chávez Juárez{p_end}
{pstd}University of Geneva{p_end}
{pstd} Geneva, Switzerland{p_end}
{pstd}{browse "mailto:florian.wendelspiess@unige.ch?subject=Stata routine iop:":florian.wendelspiess@unige.ch}{p_end}

{pstd}Isidro Soloaga{p_end}
{pstd}Universidad Iberoamericana{p_end}
{pstd}Mexico City, Mexico{p_end}
{pstd}{browse "mailto:isidro.soloaga@ibero.mx?subject=Stata routine iop:":isidro.soloaga@ibero.mx}{p_end}


{marker also_see}{...}
{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 14, number 4: {browse "http://www.stata-journal.com/article.html?article=st0361":st0361}
{p_end}
