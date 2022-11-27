<%@ include file="../shared/head.jsp" %>
<head>
    <title>Movies Manage | Category Manage</title>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container d-flex flex-column justify-content-center align-items-center py-5">
    <h2 class="text-center mb-3">Category Manage</h2>
    <div class="w-100 d-flex justify-content-end align-items-center py-3">
        <a href="<c:url value="/admin/manage-category?command=NEW"/>" class="btn btn-primary">New Category</a>
    </div>
    <div class="table-responsive w-100">
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Category Id</th>
                <th scope="col">Category Name</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="category" items="${categoryList}">
                <c:url var="updateLink" value="manage-category">
                    <c:param name="command" value="LOAD"/>
                    <c:param name="categoryId" value="${category.categoryId}"/>
                </c:url>

                <tr>
                    <td class="align-middle">${category.categoryId }</td>
                    <td class="align-middle">${category.name }</td>
                    <td class="align-middle" style="width: 200px">
                        <a href="${updateLink}" class="btn btn-primary">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <span class="mx-3"> | </span>
                        <a href="javascript:if(confirm('Are you sure?')){window.location.href='manage-category?command=DELETE&categoryId=${category.categoryId}'}"
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