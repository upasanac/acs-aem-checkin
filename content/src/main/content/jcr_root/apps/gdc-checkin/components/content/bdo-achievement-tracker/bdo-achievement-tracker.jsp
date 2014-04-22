<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/libs/foundation/global.jsp" %>
<%@page session="false" %>


<div class="row">
    <div class="col-md-12 col-xs-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Achievement (%)</h3>
            </div>
            <div class="panel-body">
                <div id="achievementChart"></div>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function(){
        var bdoAchieved = "${percentageAchieved}"; 
        GDC.bdo.achievement.tracker(bdoAchieved);
    });
</script>