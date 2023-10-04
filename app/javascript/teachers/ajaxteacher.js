let teacherId = 0;

const page = {
elements: {},
loadData: {},
commands: {},
dialogs: {
elements: {},
loadData: {},
commands: {},
}
}

const page_url = 'http://127.0.0.1:3000/manager/teachers'

    page.elements.btnShowCreateModal = $('#btnShowCreateModal');

    page.dialogs.elements.modalCreate = $('#modalCreate');
    page.dialogs.elements.modalUpdate = $('#modalUpdate');

    page.dialogs.elements.btnCreate = $('#btnCreate');
    page.dialogs.elements.btnUpdate = $('#btnUpdate');

    page.dialogs.elements.nameCre = $('#nameCre');

    page.dialogs.elements.nameUp = $('#nameUp');

    page.dialogs.commands.doUpdate = () => {
    let name = page.dialogs.elements.nameUp.val();

    const obj = {
        name: name
    }

    $.ajax({
        headers: {
            'accept': 'application/json',
            'content-type': 'application/json'
        },
        type: 'PATCH',
        url: page_url + "/" + teacherId,
        data: JSON.stringify(obj)
})
    .done((data) => {

    let str = renderTeacher(data);
    $('#tr_' + teacherId).replaceWith(str);


    page.dialogs.elements.modalUpdate.modal('hide');

    page.commands.addEventClick();

})
    .fail((error) => {
    console.log(error);
})
}

    page.dialogs.commands.doCreate = () => {
    let name = page.dialogs.elements.nameCre.val();

    const obj = {
        name: name
    }

    $.ajax({
        headers: {
            'accept': 'application/json',
            'content-type': 'application/json'
        },
        type: 'POST',
        url: page_url,
        data: JSON.stringify(obj)
    })
        .done((data) => {
            const str = renderTeacher(data);
            $("#teacher-table").append(str);
            page.dialogs.elements.modalCreate.modal('hide');

            page.commands.addEventClick();

            page.dialogs.elements.nameCre.val("");
        })
        .fail((error) => {
            console.log(error);
        })
}

    page.commands.addEventClick = () => {
    page.commands.addEventEditClick();
    page.commands.addEventDeleteClick();
}

    page.commands.addEventEditClick = () => {
    $('.edit').off('click');

    $('.edit').on('click', function () {

    $('#updateForm')[0].reset();
    teacherId = $(this).data('id');

    page.loadData.findTeacherById(teacherId).then((data) => {
        page.dialogs.elements.nameUp.val(data.name);
        page.dialogs.elements.modalUpdate.modal('show');
})
    .catch((error) => {
        console.log(error)
});
})
}

    page.commands.addEventDeleteClick = () => {
    $('.delete').off('click');

    $('.delete').on('click', function (message) {
        teacherId = $(this).data('id');

        if(confirm("Are you sure to delete this teacher?")){
            page.loadData.findTeacherById(teacherId).then((data) => {
                $.ajax({
                    headers: {
                        'accept': 'application/json',
                        'content-type': 'application/json'
                    },
                    type: 'DELETE',
                    url: page_url + '/' + teacherId,
                })
                    .done((data) => {

                        // let str = renderCustomer(data);
                        $('#tr_' + teacherId).remove();

                        page.commands.addEventClick();

                    })
                    .fail((error) => {
                        console.log(error)
                    })
            })
        }
    }
)
}


page.loadData.findTeacherById = (id) => {
    return $.ajax({
    type: 'GET',
    url: page_url + '/' + id
    })
    .done((data) => {

    })
    .fail((error) => {
    console.log(error);
    })
}

    page.loadData.getAllTeachers = () => {
    $.ajax({
        type: 'GET',
        url: page_url,
        dataType: 'json'
    })
        .done((data) => {
            console.log(data)
            data.forEach(item => {
                let str = renderTeacher(item);
                $("#teacher-table").append(str);
            });
            page.commands.addEventClick();
        })
        .fail((error) => {
            console.log(error);
        })
}

function renderTeacher(teacher) {
    return `<tr id="tr_${teacher.id}">
                <td>${teacher.id}</td>
                <td>${teacher.id}</td>
                <td>${teacher.name}</td>
                <td>
                    <button class="btn btn-primary show" data-id="${teacher.id}">Show</button>
                </td>
                <td>
                    <button class="btn btn-warning edit" data-id="${teacher.id}">Edit</button>
                </td>
                <td>
                    <button class="btn btn-danger delete" data-id="${teacher.id}">Delete</button>
                </td>
            </tr>
        `
}

    page.commands.loadData = () => {
    page.loadData.getAllTeachers();

}

    page.initializeControlEvent = () => {

    page.elements.btnShowCreateModal.on('click', () => {
    $('#createForm')[0].reset();
    page.dialogs.elements.modalCreate.modal('show');
})

    page.dialogs.elements.btnCreate.on('click', function () {
    page.dialogs.commands.doCreate();
});

    page.dialogs.elements.btnUpdate.on('click', () => {
    page.dialogs.commands.doUpdate();
})

}
    $(() => {
    page.commands.loadData();

    page.initializeControlEvent();
})
