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

const page_url = 'http://127.0.0.1:3000/manager/student_classes'

page.elements.btnShowCreateModal = $('#btnShowCreateModal');

page.dialogs.elements.modalCreate = $('#modalCreate');
// page.dialogs.elements.modalUpdate = $('#modalUpdate');
//
// page.dialogs.elements.btnCreate = $('#btnCreate');
// page.dialogs.elements.btnUpdate = $('#btnUpdate');
//
page.dialogs.elements.nameCre = $('#nameCre');
page.dialogs.elements.teacherCre = $('#teacherCre');
//
// page.dialogs.elements.nameUp = $('#nameUp');

// page.dialogs.commands.doUpdate = () => {
//     let name = page.dialogs.elements.nameUp.val();
//
//     const obj = {
//         name: name
//     }
//
//     $.ajax({
//         headers: {
//             'accept': 'application/json',
//             'content-type': 'application/json'
//         },
//         type: 'PATCH',
//         url: page_url + "/" + teacherId,
//         data: JSON.stringify(obj)
//     })
//         .done((data) => {
//
//             let str = renderTeacher(data);
//             $('#tr_' + teacherId).replaceWith(str);
//
//
//             page.dialogs.elements.modalUpdate.modal('hide');
//
//             page.commands.addEventClick();
//
//         })
//         .fail((error) => {
//             console.log(error);
//         })
// }
//
page.dialogs.commands.doCreate = () => {
    let name = page.dialogs.elements.nameCre.val();
    let teacher = page.dialogs.elements.teacherCre.val();

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

// page.commands.addEventClick = () => {
//     page.commands.addEventEditClick();
//     page.commands.addEventDeleteClick();
// }

// page.commands.addEventEditClick = () => {
//     $('.edit').off('click');
//
//     $('.edit').on('click', function () {
//
//         $('#updateForm')[0].reset();
//         teacherId = $(this).data('id');
//
//         page.loadData.findTeacherById(teacherId).then((data) => {
//             page.dialogs.elements.nameUp.val(data.name);
//             page.dialogs.elements.modalUpdate.modal('show');
//
//
//         })
//             .catch((error) => {
//                 console.log(error)
//             });
//     })
// }
//
// page.commands.addEventDeleteClick = () => {
//     $('.delete').off('click');
//
//     $('.delete').on('click', function (message) {
//             teacherId = $(this).data('id');
//
//             if(confirm("Are you sure to delete this teacher?")){
//                 page.loadData.findTeacherById(teacherId).then((data) => {
//                     $.ajax({
//                         headers: {
//                             'accept': 'application/json',
//                             'content-type': 'application/json'
//                         },
//                         type: 'DELETE',
//                         url: page_url + '/' + teacherId,
//                     })
//                         .done((data) => {
//
//                             // let str = renderCustomer(data);
//                             $('#tr_' + teacherId).remove();
//
//                             page.commands.addEventClick();
//
//                         })
//                         .fail((error) => {
//                             console.log(error)
//                         })
//                 })
//             }
//         }
//     )
// }
//
//
// page.loadData.findTeacherById = (id) => {
//     return $.ajax({
//         type: 'GET',
//         url: page_url + '/' + id
//     })
//         .done((data) => {
//
//         })
//         .fail((error) => {
//             console.log(error);
//         })
// }

page.loadData.getAllClasses = () => {
    $.ajax({
        type: 'GET',
        url: page_url,
        dataType: 'json'
    })
        .done((data) => {
            data.forEach(item => {
                let str = renderClass(item);
                $("#class-table").append(str);
            });
            // page.commands.addEventClick();
        })
        .fail((error) => {
            console.log(error);
        })
}

page.loadData.getAllTeachers = () => {
    $.ajax({
        type: 'GET',
        url: 'http://127.0.0.1:3000/manager/teachers',
        dataType: 'json'
    })
        .done((data) => {
            console.log(data)
            page.dialogs.elements.teacherCre.empty();
            // page.dialogs.elements.teacherUp.empty();
            $.each(data, (i, item) => {
                let str = renderTeacher(item);
                page.dialogs.elements.teacherCre.append(str);
                // page.dialogs.elements.rateUp.append(str);
            })
        })
        .fail((error) => {
            console.log(error);
        })

}

function renderTeacher(obj) {
    return `
                    <option value="${obj.id}">${obj.name}</option>
                `;
}

function renderClass(student_class) {
    return `<tr id="tr_${student_class.id}">
                <td>${student_class.id}</td>
                <td>${student_class.id}</td>
                <td>${student_class.name}</td>
                <td>
                    <button class="btn btn-primary show" data-id="${student_class.id}">Show</button>
                </td>
                <td>
                    <button class="btn btn-warning edit" data-id="${student_class.id}">Edit</button>
                </td>
                <td>
                    <button class="btn btn-danger delete" data-id="${student_class.id}">Delete</button>
                </td>
            </tr>
        `
}

page.commands.loadData = () => {
    page.loadData.getAllClasses();
    page.loadData.getAllTeachers();
}

page.initializeControlEvent = () => {

    page.elements.btnShowCreateModal.on('click', () => {
        $('#createForm')[0].reset();
        page.dialogs.elements.modalCreate.modal('show');
    })

    // page.dialogs.elements.btnCreate.on('click', function () {
    //     page.dialogs.commands.doCreate();
    // });
    //
    // page.dialogs.elements.btnUpdate.on('click', () => {
    //     page.dialogs.commands.doUpdate();
    // })

}
$(() => {
    page.commands.loadData();

    page.initializeControlEvent();
})
