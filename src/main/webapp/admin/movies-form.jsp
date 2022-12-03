<%@ include file="../shared/head.jsp" %>
<head>
    <title>Admin Page | Manage User</title>
</head>
<body style="overflow-x: hidden">
<c:if test="${message != null}">
    <input id="notification" type="hidden" value="${message}">
</c:if>

<div style="width: 100vw; height: 100vh">
    <%@ include file="header.jsp" %>
    <div class="container d-flex justify-content-center align-items-center  py-5"
         style="min-height: calc(100vh - 56px);">
        <div style="max-width: 680px; width: 100%">
            <c:choose>
                <c:when test="${theMovie != null && not empty theMovie.movieId}">
                    <c:url var="actionLink" value="manage-movies">
                        <c:param name="command" value="UPDATE"/>
                        <c:param name="movieId" value="${theMovie.movieId}"/>
                    </c:url>
                    <h2 class="text-center mb-4">Update movie</h2>
                </c:when>

                <c:otherwise>
                    <c:url var="actionLink" value="manage-movies">
                        <c:param name="command" value="INSERT"/>
                    </c:url>
                    <h2 class="text-center mb-4">Create new movie</h2>
                </c:otherwise>
            </c:choose>
            <form id="addNewMovieForm" method="post"
                  aria-controls="<c:if test="${theMovie != null && not empty theMovie.movieId}">updateForm</c:if>"
                  enctype="multipart/form-data">
                <c:if test="${theMovie != null}">
                    <input type="hidden" name="movieId" id="theMovieIdInput" value="${theMovie.movieId}">
                    <input type="hidden" id="theSelectedCategory" value="${theMovie.category.name}"/>
                    <input type="hidden" id="theImageLinkInput" value="${theMovie.image}"/>
                    <input type="hidden" id="theMovieLinkInput" value="${theMovie.movieLink}"/>
                </c:if>
                <div class="mb-3">
                    <label class="form-label" for="selectCategory">Category</label>
                    <select name="category" class="form-select" id="selectCategory">
                        <option value="" selected>Select a category</option>
                        <c:forEach items="${categoryList}" var="category">
                            <option value="${category.categoryId}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="movieNameInput">Movie Name</label>
                    <input name="name" type="text" class="form-control" id="movieNameInput"
                           placeholder="Movie name" value="${theMovie.name}">
                    <div class="invalid-feedback">Please input movie name</div>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="publishDate">Publish date</label>
                    <input name="publishDate" type="date"
                           value='<fmt:formatDate pattern="yyyy-MM-dd" value="${theMovie.publishDate}" />'
                           class="form-control" id="publishDate" placeholder="publishDate">
                    <div class="invalid-feedback">Please input publish date</div>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="directorInput">Director</label>
                    <input name="director" type="text" class="form-control" id="directorInput"
                           placeholder="Director" value="${theMovie.director}"/>
                    <div class="invalid-feedback">Please input director name</div>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="descriptionInput">Description</label>
                    <textarea name="description" class="form-control" id="descriptionInput"
                              placeholder="Description">${theMovie.description}</textarea>
                    <div class="invalid-feedback">Please input description</div>
                </div>
                <div class="mb-3">
                    <label for="imageInput" class="form-label">Upload movie poster</label>
                    <input class="form-control" type="file" id="imageInput" name="image"/>
                    <div class="invalid-feedback">Please upload movie poster</div>
                </div>
                <div id="imagePreview" class="mb-3">
                    <div class="progress d-none" id="uploadImageProgressContainer">
                        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"
                             id="uploadImageProgress"></div>
                    </div>
                </div>
                <div class="mb-3 w-100">
                    <c:choose>
                        <c:when test="${theMovie != null && not empty theMovie.movieId}">
                            <img id="preview-image-before-upload"
                                 src="${theMovie.image}"
                                 style="width: 240px; object-fit:cover;" alt="${theMovie.name}"/>
                        </c:when>
                    </c:choose>
                </div>
                <div class="mb-3">
                    <label for="movieFileInput" class="form-label">Upload movie</label>
                    <input class="form-control" type="file" id="movieFileInput" name="movieFileInput"/>
                    <div class="invalid-feedback">Please upload movie</div>
                </div>
                <div id="moviePreview" class="mb-3">
                    <div class="progress d-none" id="uploadMovieProgressContainer">
                        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"
                             id="uploadMovieProgress"></div>
                    </div>
                    <c:choose>
                        <c:when test="${theMovie != null && not empty theMovie.movieId}">
                            <video width="100%" controls id="updatePreviewMovie">
                                <source src="${theMovie.movieLink}"
                                        type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
                        </c:when>
                    </c:choose>
                </div>
                <div class="d-flex justify-content-center">
                    <button id="submitBtn" type="submit" class="btn btn-primary">Submit</button>
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
    var theSelectedCategory = document.getElementById("theSelectedCategory");

    if (theSelectedCategory != null && theSelectedCategory.value.length > 0) {
        var fieldProductCategory = document.getElementById("selectCategory");
        var options = Array.from(fieldProductCategory.options);
        var optionToSelect = options.find(item => item.text === theSelectedCategory.value);
        optionToSelect.selected = true;
    }

</script>

<script type="text/javascript">
    const movieId = $("#theMovieIdInput").val()
    $(document).ready(function () {
        $("#addNewMovieForm").validate({
            rules: {
                name: {required: true},
                director: {required: true},
                description: {required: true},
                movieFileInput: {required: !movieId},
                publishDate: {required: true},
                image: {required: !movieId},
                category: {required: true},
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
<script type="module">
    import {initializeApp} from 'https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js'
    import {
        getStorage,
        ref,
        uploadBytesResumable,
        getDownloadURL
    } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-storage.js"
    import env from "<c:url value="/env.json"/>" assert {type: "json"}

    const firebaseConfig = {
        apiKey: env.API_KEY,
        authDomain: env.AUTH_DOMAIN,
        projectId: env.PROJECT_ID,
        storageBucket: env.STORAGE_BUCKET,
        messagingSenderId: env.MESSAGING_SENDER_ID,
        appId: env.APP_ID
    }

    const app = initializeApp(firebaseConfig)
    const storage = getStorage(app)
    let movieLink = ""
    let imageLink = ""
    // upload image to firebase
    $("#imageInput").change((e) => {
        const imageFile = e.target.files[0]
        const imageTypes = ['apng', 'apng', 'gif', 'jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'png', 'svg', 'webp']

        if (!imageTypes.includes(imageFile?.type?.replace("image/", ""))) {
            alert("Image upload incorrect content type. Require: " + imageTypes.join('/'))
            $("#imageInput").val("")
        } else {
            // disable submit button
            $("#submitBtn").attr("disabled", true);
            // Upload file and metadata to the object 'images/mountains.jpg'
            const storageRef = ref(storage, 'images/' + (new Date() + "-" + imageFile.name).replaceAll(" ", "-"));
            const uploadTask = uploadBytesResumable(storageRef, imageFile, {
                contentType: imageFile.type
            });

            // Listen for state changes, errors, and completion of the upload.
            uploadTask.on('state_changed',
                (snapshot) => {
                    // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
                    const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                    const uploadImageProgress = $("#uploadImageProgress")
                    $("#uploadImageProgressContainer").removeClass("d-none")
                    uploadImageProgress.css('width', Math.floor(progress) + '%')
                    uploadImageProgress.text(Math.floor(progress) + '%')
                },
                (error) => {
                    console.log(error)
                },
                () => {
                    // Upload completed successfully, now we can get the download URL
                    getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
                        $("#preview-image-before-upload").addClass("d-none")
                        $("#uploadImageProgressContainer").addClass("d-none")
                        $("#imagePreview").append(`
                            <label class="form-label">Image preview</label>
                            <img src="` + downloadURL + `"  alt="image-preview"/>`)
                        imageLink = downloadURL
                        $("#submitBtn").attr("disabled", false)
                    });
                }
            );
        }
    })

    // upload movie to firebase
    $("#movieFileInput").change((e) => {
        const videoFile = e.target.files[0]
        // if ($("#addNewMovieForm").attr('aria-controls') === 'updateForm') {
        //     $("updatePreviewMovie").hide()
        // }
        if (videoFile?.type !== "video/mp4") {
            alert("Video upload incorrect content type. Require: mp4")
            $("#movieFileInput").val("")
        } else {
            // disable submit button
            $("#submitBtn").attr("disabled", true);
            // Upload file and metadata to the object 'images/mountains.jpg'
            const storageRef = ref(storage, 'movies/' + (new Date() + "-" + videoFile.name).replaceAll(" ", "-"));
            const uploadTask = uploadBytesResumable(storageRef, videoFile, {
                contentType: videoFile.type
            });

            // Listen for state changes, errors, and completion of the upload.
            uploadTask.on('state_changed',
                (snapshot) => {
                    // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
                    const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                    const uploadMovieProgress = $("#uploadMovieProgress")
                    $("#uploadMovieProgressContainer").removeClass("d-none")
                    uploadMovieProgress.css('width', Math.floor(progress) + '%')
                    uploadMovieProgress.text(Math.floor(progress) + '%')
                },
                (error) => {
                    console.log(error)
                },
                () => {
                    // Upload completed successfully, now we can get the download URL
                    getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
                        $("#uploadMovieProgressContainer").addClass("d-none")
                        $("#updatePreviewMovie").addClass("d-none")
                        $("#moviePreview").append(`
                            <label class="form-label">Movie preview</label>
                            <video width="100%" controls>
                                <source src="` + downloadURL + `"
                                        type="video/mp4" >
                                Your browser does not support the video tag.
                            </video>`)
                        movieLink = downloadURL
                        $("#submitBtn").attr("disabled", false)
                    });
                }
            );
        }
    })

    $("#submitBtn").click((event) => {
        event.preventDefault()
        const data = new FormData()
        const movieId = $("#theMovieIdInput").val()

        if (!movieId) {
            data.append("category", $("#selectCategory").val())
            data.append("name", $("#movieNameInput").val())
            data.append("director", $("#directorInput").val())
            data.append("movieLink", movieLink)
            data.append("description", $("#descriptionInput").val())
            data.append("publishDate", $("#publishDate").val())
            data.append("imageLink", imageLink)
        }

        if (movieId) {
            data.append("movieId", movieId)
            data.append("category", $("#selectCategory").val())
            data.append("name", $("#movieNameInput").val())
            data.append("director", $("#directorInput").val())
            data.append("movieLink", movieLink || $("#theMovieLinkInput").val())
            data.append("description", $("#descriptionInput").val())
            data.append("publishDate", $("#publishDate").val())
            data.append("imageLink", imageLink || $("#theImageLinkInput").val())
        }

        $.ajax({
            type: "POST",
            url: movieId ? "/movie_war/admin/manage-movies?command=UPDATE&movieId=" + movieId : "/movie_war/admin/manage-movies?command=INSERT",
            data: data,
            processData: false,
            contentType: false,
            success: () => {
                window.location.href = "/movie_war/admin/manage-movies?command=LIST"
            },
            error: (error) => {
                console.log("error", error)
            }
        })
    })
</script>
</body>