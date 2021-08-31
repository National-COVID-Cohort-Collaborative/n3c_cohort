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
        {"value":"randomforest_feature_rank", "label":"Random Forest", "title":"Random forest is a machine learning algorithm that combines the results of many individual decision trees to create a prediction model."},
        {"value":"xgboost_feature_ran", "label":"XGBoost", "title":"XGBoost is a type of Gradient boosting algorithm used in machine learning to create a prediction model that is designed for speed and performance."},
        {"value":"logisticregression_none_feature_rank", "label":"None", "title":"Logistic Regression  is a statistical method used to assign the probability of an event happening such as pass/fail, win/lose, alive/dead or healthy/sick."},
        {"value":"logisticregression_l1_feature_rank", "label":"L1", "title":"L1 is a type of logistic regression that tries to reduce the weight of variables by removing them from the model."},
        {"value":"logisticregression_l2_feature_rank", "label":"L2", "title":"L2 is a type of logistic regression tries to reduce the weight of variables but retains all the initial variables."},
        {"value":"logisticregression_elasticnet_feature_rank", "label":"Elastic Net", "title":"Elastic Net is a type of logistic regression that combines L1 & L2 methods."},
        {"value":"ridgeclassifier_feature_rank", "label":"Ridge Classifier", "title":"The Ridge Classifier prepares data for analysis by converting all target variables to a -1 or 1 in order to perform a statistical method called a Ridge Regression commonly used in machine learning."},
        {"value":"mean", "label":"Mean"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>
}
