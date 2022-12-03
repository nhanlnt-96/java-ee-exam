<%@ include file="../shared/head.jsp" %>
<head>
    <title>Admin Page | Movies Manage</title>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container d-flex flex-column justify-content-center align-items-center py-5">
    <h2 class="text-center mb-3">Movie Manage</h2>
    <div class="w-100 d-flex justify-content-end align-items-center py-3">
        <a href="<c:url value="/admin/manage-movies?command=NEW"/>" class="btn btn-primary">New Movie</a>
    </div>
    <div class="table-responsive w-100">
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Movie Id</th>
                <th scope="col">Movie's Name</th>
                <th scope="col">Movie's Category</th>
                <th scope="col">Movie's Poster</th>
                <th scope="col">Movie's Director</th>
                <th scope="col">Movie's Description</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="movie" items="${moviesList}">
                <c:url var="updateLink" value="manage-movies">
                    <c:param name="command" value="LOAD"/>
                    <c:param name="movieId" value="${movie.movieId}"/>
                </c:url>

                <tr>
                    <td class="align-middle p-2">${movie.movieId}</td>
                    <td class="align-middle p-2">${movie.name}</td>
                    <td class="align-middle p-2">${movie.category.name}</td>
                    <td class="align-middle p-2">
                        <img src="${movie.image}" alt="${movie.name}"
                             style="width: 130px; height: 180px; object-fit: contain;">
                    </td>
                    <td class="align-middle p-2">${movie.director}</td>
                    <td class="align-middle p-2" style="width: 350px; text-align: justify">${movie.description}</td>
                    <td class="align-middle p-2" style="width: 200px">
                        <a href="${updateLink}" class="btn btn-primary">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <span class="mx-3"> | </span>
                        <a href="javascript:if(confirm('Are you sure?')){window.location.href='manage-movies?command=DELETE&movieId=${movie.movieId}'}"
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