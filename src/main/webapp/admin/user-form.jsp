<%@ include file="../shared/head.jsp" %>
<head>
    <title>Admin Page | Manage User</title>
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
                <c:when test="${theUser != null && not empty theUser.userId}">
                    <c:url var="actionLink" value="manage-user">
                        <c:param name="command" value="UPDATE"/>
                        <c:param name="userId" value="${theUser.userId}"/>
                    </c:url>
                    <h2 class="text-center mb-4">Update user</h2>
                </c:when>

                <c:otherwise>
                    <c:url var="actionLink" value="manage-user">
                        <c:param name="command" value="INSERT"/>
                    </c:url>
                    <h2 class="text-center mb-4">Create new user</h2>
                </c:otherwise>
            </c:choose>
            <form id="addNewUserForm" action="${actionLink}" method="post"
                  aria-controls="<c:if test="${theUser != null && not empty theUser.userId}">updateForm</c:if>">
                <div class="mb-3">
                    <label for="emailInput" class="form-label">Email address</label>
                    <input type="email" class="form-control" name="email" id="emailInput" value="${theUser.email}"
                           <c:if test="${theUser != null && not empty theUser.email}">disabled</c:if>/>
                    <div class="invalid-feedback">Please input valid email address</div>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="userFullNameInput">Full name</label>
                    <input name="fullName" type="text" class="form-control" id="userFullNameInput"
                           placeholder="Full name" value="${theUser.fullName}">
                    <div class="invalid-feedback">Please input user full name</div>
                </div>
                <div class="mb-3">
                    <label for="passwordInput" class="form-label">Password</label>
                    <input type="password" class="form-control" id="passwordInput" name="password"/>
                    <div class="invalid-feedback">Please input password</div>
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
        $("#addNewUserForm").validate({
            rules: {
                email: {required: true, email: true},
                fullName: {required: true, minlength: 2},
                password: {required: !($('#addNewUserForm').attr('aria-controls') === 'updateForm'), minLength: 6},
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