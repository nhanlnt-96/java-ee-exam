<nav class="navbar navbar-expand-lg bg-light">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="<c:url value="/admin" />">Movies Manage</a>
        <%--        <c:if test="${sessionScope.userEmail != null}">--%>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02"
                aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<c:url value="/admin" />">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value="/admin/manage-category" />">Category Manage</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value="/admin/manage-user" />">User Manage</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active">Movie Manage</a>
                </li>
            </ul>
            <div class="d-flex justify-content-center align-items-center">
                <p class="mb-0">Welcome, <c:out value="${sessionScope.userEmail}"/></p>
                <span class="mx-3">|</span>
                <button class="btn btn-outline-secondary">Logout</button>
            </div>
        </div>
        <%--        </c:if>--%>
    </div>
</nav>