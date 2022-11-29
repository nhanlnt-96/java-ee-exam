<%@ include file="../shared/head.jsp" %>
<head>
    <title>Admin Page | Add new User</title>
</head>
<body>
<c:if test="${message != null}">
    <input id="notification" type="hidden" value="${message}">
</c:if>

<div style="width: 100vw; height: 100vh">
    <%@ include file="header.jsp" %>
    <div class="container d-flex justify-content-center align-items-center  py-5" style="min-height: calc(100vh - 56px);">
        <div style="max-width: 680px; width: 100%">
            <c:choose>
                <c:when test="${theCategory != null && not empty theCategory.categoryId}">
                    <c:url var="actionLink" value="manage-category">
                        <c:param name="command" value="UPDATE"/>
                        <c:param name="categoryId" value="${theCategory.categoryId}"/>
                    </c:url>
                    <h2 class="text-center mb-4">Update category</h2>
                </c:when>

                <c:otherwise>
                    <c:url var="actionLink" value="manage-category">
                        <c:param name="command" value="INSERT"/>
                    </c:url>
                    <h2 class="text-center mb-4">Create new category</h2>
                </c:otherwise>
            </c:choose>
            <form id="addNewCategoryForm" action="${actionLink}" method="post"
                  aria-controls="<c:if test="${theCategory != null && not empty theCategory.categoryId}">updateForm</c:if>">
                <div class="mb-3">
                    <label class="form-label" for="categoryNameInput">Category Name</label>
                    <input name="name" type="text" class="form-control" id="categoryNameInput"
                           placeholder="Category name" value="${theCategory.name}">
                    <div class="invalid-feedback">Please input category name</div>
                </div>
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../shared/scripts.jsp" %>
<script type="text/javascript">
    var notification = document.getElementById("notification");

    if (notification != null && notification.value.length > 0) {
        // console.log(notification.value);
        alertify.error(notification.value);
    }
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#addNewCategoryForm").validate({
            rules: {
                name: {required: true, minlength: 2},
            },
            /* add bootstrap class is-valid & is-invalid */
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).addClass("is-valid").removeClass("is-invalid");
            },
            /* hide default label error message of jquery-validation */
            errorPlacement: function (error, element) {
            }
        });
    })
</script>
</body>