<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select json_agg(foo)
	from (select variable, 
		randomforest_feature_rank, 
		xgboost_feature_rank, 
		logisticregression_none_feature_rank, 
		logisticregression_l1_feature_rank, 
		logisticregression_l2_feature_rank, 
		((randomforest_feature_rank::float+xgboost_feature_rank::float+logisticregression_none_feature_rank::float+logisticregression_l1_feature_rank::float+logisticregression_l2_feature_rank::float)/5) as mean
	from enclave_cohort_paper.generate_models_and_summary_info
	where 
		randomforest_feature_rank is not null and
		xgboost_feature_rank  is not null and
		logisticregression_none_feature_rank is not null and
		logisticregression_l1_feature_rank is not null and
		logisticregression_l2_feature_rank is not null
	order by mean asc) as foo;
</sql:query>
{
    "headers": [
        {"value":"variable", "label":"Variable"},
        {"value":"randomforest_feature_rank", "label":"Random Forest"},
        {"value":"xgboost_feature_ran", "label":"XG Boost"},
        {"value":"logisticregression_none_feature_rank", "label":"None"},
        {"value":"logisticregression_l1_feature_rank", "label":"L1"},
        {"value":"logisticregression_l2_feature_rank", "label":"L2"},
        {"value":"mean", "label":"Mean"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>
}
