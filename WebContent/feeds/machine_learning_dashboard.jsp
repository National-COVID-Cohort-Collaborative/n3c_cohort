<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select json_agg(foo)
	from (select label as variable, 
		randomforest_feature_rank, 
		xgboost_feature_rank, 
		logisticregression_none_feature_rank, 
		logisticregression_l1_feature_rank, 
		logisticregression_l2_feature_rank, 
		logisticregression_elasticnet_feature_rank,
		ridgeclassifier_feature_rank,
		round(((randomforest_feature_rank+
		xgboost_feature_rank+
		logisticregression_none_feature_rank+
		logisticregression_l1_feature_rank+
		logisticregression_l2_feature_rank+
		logisticregression_elasticnet_feature_rank+
		ridgeclassifier_feature_rank)/7)::numeric, 2) as mean
	from enclave_cohort_paper.generate_models_and_summary_info
	join enclave_cohort_paper.ml_variable_mapping  
	on (enclave_cohort_paper.generate_models_and_summary_info.variable = enclave_cohort_paper.ml_variable_mapping.var)
	where
		randomforest_feature_rank is not null and
		xgboost_feature_rank  is not null and
		logisticregression_none_feature_rank is not null and
		logisticregression_l1_feature_rank is not null and
		logisticregression_l2_feature_rank is not null and
		logisticregression_elasticnet_feature_rank is not null and
		ridgeclassifier_feature_rank is not null
	order by mean asc) as foo;
</sql:query>
{
    "headers": [
        {"value":"variable", "label":"Variable"},
        {"value":"randomforest_feature_rank", "label":"Random Forest"},
        {"value":"xgboost_feature_ran", "label":"XGBoost"},
        {"value":"logisticregression_none_feature_rank", "label":"None"},
        {"value":"logisticregression_l1_feature_rank", "label":"L1"},
        {"value":"logisticregression_l2_feature_rank", "label":"L2"},
        {"value":"logisticregression_elasticnet_feature_rank", "label":"Elastic Net"},
        {"value":"ridgeclassifier_feature_rank", "label":"Ridge Classifier"},
        {"value":"mean", "label":"Mean"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>
}
