<%@ include file="../shared/head.jsp" %>
<head>
    <title>Movies Manage | Add new User</title>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container d-flex flex-column justify-content-center align-items-center py-5">
    <div class="w-100 d-flex justify-content-end align-items-center">
        <a href="<c:url value="/admin/manage-user?command=NEW"/>" class="btn btn-primary">New User</a>
    </div>
    <div class="table-responsive w-100">
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">User Id</th>
                <th scope="col">Full Name</th>
                <th scope="col">Email</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${userList}">
                <c:url var="updateLink" value="manage-user">
                    <c:param name="command" value="LOAD"/>
                    <c:param name="userId" value="${user.userId}"/>
                </c:url>

                <tr>
                    <td class="align-middle">${user.userId }</td>
                    <td class="align-middle">${user.fullName }</td>
                    <td class="align-middle">${user.email }</td>
                    <td class="align-middle" style="width: 200px">
                        <a href="${updateLink}" class="btn btn-primary">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <span class="mx-3"> | </span>
                        <a href="javascript:if(confirm('Are you sure?')){window.location.href='manage-user?command=DELETE&userId=${user.userId}'}"
                           class="btn btn-danger">
                            <i class="fa-solid fa-trash-can"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>