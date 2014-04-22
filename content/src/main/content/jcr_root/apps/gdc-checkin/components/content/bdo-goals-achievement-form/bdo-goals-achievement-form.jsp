<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/libs/foundation/global.jsp" %>
<%@page session="false" %>
<%@page import="com.adobe.gdc.checkin.QuarterlyBDORepositoryClient, com.adobe.gdc.checkin.UserManagementService,java.util.Map, javax.jcr.Session" %>

<c:set var="percentageList" value="${fn:split('10,20,30,40,50,60,70,80,90,100', ',')}" scope="application" />
<c:set var="quarterNumber" value="${quarterNumber}" />
<c:set var="annualYear" value="${annualYear}" />

<%
QuarterlyBDORepositoryClient quarterlyBDORepositoryClient = sling.getService(QuarterlyBDORepositoryClient.class);
UserManagementService userManagementService = sling.getService(UserManagementService.class);

Session session = resourceResolver.adaptTo(Session.class);
int quarterNumber = ((Integer) pageContext.getAttribute("quarterNumber")).intValue();
int annualYear = ((Integer) pageContext.getAttribute("annualYear")).intValue();

Map<String, String[]> quarterlyBDODataMap = quarterlyBDORepositoryClient.getQuarterlyBDOData(quarterNumber,annualYear,session);
%>

<c:set var="bdoObjectives" value="<%=quarterlyBDODataMap.get("objectives")%>" scope="request"/>
<c:set var="bdoAchievements" value="<%=quarterlyBDODataMap.get("achievements")%>" scope="request"/>
<c:set var="percentageAchieved" value="<%=quarterlyBDODataMap.get("percentageAchieved") != null ? quarterlyBDODataMap.get("percentageAchieved")[0] : ""%>" scope="request"/>

<c:choose>
  <c:when test = "${currentQuarter eq 'true'}">
  	<c:set var="designation" value="<%=userManagementService.getEmployeeDesignation(session)%>" scope="request"/>
  </c:when>
  <c:otherwise>
  	<c:set var="designation" value="<%=quarterlyBDODataMap.get("designation")!= null ? quarterlyBDODataMap.get("designation")[0] : ""%>" scope="request"/>
  </c:otherwise>
</c:choose>


<div class="row">

    <div class="col-md-9 col-xs-9">
        <div class="bdo-form">
            <div class="row">
                <div class="col-md-4 col-xs-4"></div>                
                <div class="col-md-7 col-xs-7 align-right">
                    <div class="col-sm-10  col-xs-10 col-md-10">
                        <label for="EmployeeId"> Designation:  </label>
                        ${designation}<br/><br/>
                    </div>
                    <div class="col-sm-2  col-xs-2 col-md-2  align-left"></div>
                </div>
                <div class="col-md-1 col-xs-1"></div>
            </div>

            <c:choose>
                <c:when test = "${currentQuarter eq 'true'}">

                    <div class="row">
                        <div class="col-md-1 col-xs-1"></div>
                        <div class="col-md-8 col-xs-8" id="form-message"></div>
                    </div>
                    <br/>

                    <form id="quarterly-bdo-form" class="quarterly-bdo-form" method="POST" action="<%=currentPage.getPath()%>.bdo">

                        <input type="hidden" name="designation" id="designation" value="${designation}" />
                        <input type="hidden" name="quarterNumber" id="quarterNumber" value="${quarterNumber}" />

                        <div class="row">
                            <div class="col-md-1 col-xs-1"></div>
                            <div class="col-md-2 col-xs-2">
                                <label for="objective">
                                    Set your Objectives
                                </label><br/>
                                <span class="objective-desc">
                                    Delight the Company<br/>Delight the Customer<br/>Delight the Employee
                                </span>
                            </div>
                            <div class="col-md-8 col-xs-8  bdo-objective-panel">
                                <div class="row bdo-objective-active bdo-objective-panel-row">
                                    <div class="col-sm-10  col-xs-10 col-md-10">
                                        <textarea id="objective_1" type="text" name="objective" placeholder="Objective" class="form-control objective" rows="1" cols="50">
                                        </textarea>
                                    </div>
                                    <div class="col-sm-2  col-xs-2 col-md-2 align-left button-wrapper">
                                        <button class="btn btn-danger btn-remove" type="button" style="display:none">
                                            <span class="glyphicon glyphicon-remove"></span>
                                        </button>
                                        <button class="btn btn-primary btn-add" type="button">
                                            <span class="glyphicon glyphicon-plus"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1 col-xs-1"></div>
                        </div>
        
                        <br/>
        
                        <div class="row">
                            <div class="col-md-1 col-xs-1"></div>
                            <div class="col-md-2 col-xs-2">
                                <label for="achievement">
                                    BDO Achievements inputs
                                </label>
                            </div>
                            <div class="col-md-8 col-xs-8 bdo-achievement-panel">
                                <div class="row bdo-achievement-active bdo-achievement-panel-row">
                                    <div class="col-sm-10  col-xs-10 col-md-10">
                                        <textarea id="achievement_1" type="text" name="achievement" placeholder="Achievement" class="form-control achievement" rows="1" cols="50">
                                        </textarea>
                                    </div>
                                    <div class="col-sm-2  col-xs-2 col-md-2  align-left button-wrapper">
                                        <button class="btn btn-danger btn-remove" type="button" style="display:none">
                                            <span class="glyphicon glyphicon-remove"></span>
                                        </button>
                                        <button class="btn btn-primary btn-add" type="button">
                                            <span class="glyphicon glyphicon-plus"></span>
                                        </button>
                                    </div>
                                </div>  
                            </div>
                            <div class="col-md-1 col-xs-1"></div>
                        </div>
    
                        <br/>
    
                        <div class="row">
                            <div class="col-md-1 col-xs-1"></div>
                            <div class="col-md-2 col-xs-2">
                                <label for="percentageAchieved">
                                    Percentage Achieved
                                </label>
                            </div>
                            <div class="col-md-8 col-xs-8">
                                <select name="percentageAchieved" id="percentageAchieved">
                                    <option value=""  selected}>Please select</option>
                                    <c:forEach items="${percentageList}" var="percent">
                                        <option value="${percent}" ${percent eq percentageAchieved ? 'selected' : ''}>${percent}</option>
                                     </c:forEach>
                                </select> %
                            </div>
                            <div class="col-md-1 col-xs-1"></div>
                        </div>
    
                        <br/>
    
                        <div class="row">
                            <div class="col-md-4 col-xs-4"></div>
                            <div class="col-md-7 col-xs-7 align-right">
                                <div class="col-sm-10  col-xs-10 col-md-10">
                                    <button type="button" class="btn btn-primary btn-save">Save</button> &nbsp;
                                    <button type="button" class="btn btn-primary btn-submit">Submit</button>
                                </div>
                                <div class="col-sm-2  col-xs-2 col-md-2  align-left"></div>
                            </div>
                            <div class="col-md-1 col-xs-1"></div>
                        </div>

                    </form>

                </c:when>
            
                <c:otherwise>
                    <label for="objective">  Objectives </label>
                        ${bdoObjectives}
                    <label for="achievement"> BDO Achievements </label>
                        ${bdoAchievements}

                    ${percentageAchieved}
                    
                </c:otherwise>

            </c:choose>
        </div>

    </div>

    <div class="col-md-3 col-xs-3">
        <c:if test = "${currentQuarter eq 'true'}">
            <cq:include path="bdo-achievement-tracker" resourceType= "gdc-checkin/components/content/bdo-achievement-tracker" />
        </c:if>
    </div>

</div>



<script>
    $(document).ready(function() {

		var bdoObjectivesArray = [];
        var bdoAchievementsArray = [];

		<c:forEach items="${bdoObjectives}" var="objective">
   			 bdoObjectivesArray.push('${objective}'); 
		</c:forEach>

		<c:forEach items="${bdoAchievements}" var="achievement">
   			 bdoAchievementsArray.push('${achievement}'); 
		</c:forEach>

        if(${currentQuarter} == true) {

			GDC.bdo.form(bdoObjectivesArray,bdoAchievementsArray);
       }
});
</script>