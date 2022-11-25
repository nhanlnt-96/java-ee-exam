<%@ include file="../shared/head.jsp" %>
<head>
    <title>Movies Manage | Login</title>
</head>
<body>
<div style="width: 100vw; height: 100vh">
    <%@ include file="header.jsp" %>
    <div class="container d-flex justify-content-center align-items-center" style="height: calc(100vh - 56px);">
        <div style="max-width: 680px; width: 100%">
            <h2 class="text-center mb-2">Please login</h2>
            <form id="adminLoginForm" action="login">
                <div class="form-floating mb-3">
                    <label for="emailInput" class="form-label">Email address</label>
                    <input type="email" class="form-control" name="email" id="emailInput"/>
                    <div class="invalid-feedback">Please input valid email address</div>
                </div>
                <div class="form-floating mb-3">
                    <label for="passwordInput" class="form-label">Password</label>
                    <input type="password" class="form-control" id="passwordInput" name="password"/>
                    <div class="invalid-feedback">Please input password</div>
                </div>
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary">Login</button>
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
        $("#adminLoginForm").validate({
            rules: {
                email: {required: true, email: true},
                password: {required: true},
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