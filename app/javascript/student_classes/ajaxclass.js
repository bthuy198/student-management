// let classId = 0;
// let teacherId = 0;
//
// const page = {
//     elements: {},
//     loadData: {},
//     commands: {},
//     dialogs: {
//         elements: {},
//         loadData: {},
//         commands: {},
//     }
// }
//
// const page_url = 'http://127.0.0.1:3000/manager/student_classes'
//
// page.elements.btnShowCreateModal = $('#btnShowCreateModal');
//
// page.dialogs.elements.modalCreateClass = $('#modalCreateClass');
// page.dialogs.elements.modalUpdateClass = $('#modalUpdateClass');
//
// page.dialogs.elements.btnCreate = $('#btnCreate');
// page.dialogs.elements.btnUpdate = $('#btnUpdate');
//
// page.dialogs.elements.nameCre = $('#nameCre');
// page.dialogs.elements.teacherCre = $('#teacherCre');
//
// page.dialogs.elements.nameUp = $('#nameUp');
// page.dialogs.elements.teacherUp = $('#teacherUp');
//
// page.dialogs.commands.doUpdate = () => {
//     let name = page.dialogs.elements.nameUp.val();
//     let teacher_id = page.dialogs.elements.teacherUp.find('option:selected').val();
//     console.log('teacher_id', teacher_id)
//
//     const obj = {
//         name: name,
//         teacher_id: teacher_id
//     }
//
//     $.ajax({
//         headers: {
//             'accept': 'application/json',
//             'content-type': 'application/json'
//         },
//         type: 'PATCH',
//         url: page_url + "/" + classId,
//         data: JSON.stringify(obj)
//     })
//         .done((data) => {
//             teacherId = data.teacher_id
//             page.loadData.findTeacherById(teacherId).then((teacher) => {
//                 let str = renderClass(data, teacher);
//                 $('#tr_' + classId).replaceWith(str);
//             })
//
//             page.dialogs.elements.modalUpdateClass.modal('hide');
//
//             page.commands.removeAllEvent();
//             page.commands.addEventClick();
//
//         })
//         .fail((error) => {
//             console.log(error);
//         })
// }
//
// page.dialogs.commands.doCreate = () => {
//     let name = page.dialogs.elements.nameCre.val();
//     let teacher_id = +page.dialogs.elements.teacherCre.find("option:selected").val();
//     console.log(teacher_id)
//
//     const obj = {
//         name: name,
//         teacher_id: teacher_id
//     }
//
//     console.log(obj)
//
//     $.ajax({
//         headers: {
//             'accept': 'application/json',
//             'content-type': 'application/json'
//         },
//         type: 'POST',
//         url: page_url,
//         data: JSON.stringify(obj)
//     })
//         .done((data) => {
//             page.loadData.findTeacherById(data.teacher_id).then((teacher) => {
//                 let str = renderClass(data, teacher);
//                 $("#class-table").append(str);
//             })
//             page.dialogs.elements.modalCreateClass.modal('hide');
//
//             page.commands.addEventClick();
//
//             page.dialogs.elements.nameCre.val("");
//         })
//         .fail((error) => {
//             console.log(error);
//         })
// }
//
// page.commands.addEventClick = () => {
//     page.commands.addEventEditClick();
//     page.commands.addEventDeleteClick();
// }
//
// page.commands.removeAllEvent = () => {
//     $(".edit").off("click");
//     $(".delete").off("click");
// }
//
// page.commands.addEventEditClick = () => {
//     $('.edit').on('click', function () {
//
//         console.log('click')
//         $('#updateForm')[0].reset();
//         classId = $(this).data('id');
//         console.log('class id==', classId)
//
//         page.loadData.findClassById(classId).then((data) => {
//             page.dialogs.elements.nameUp.val(data.name);
//             page.dialogs.elements.teacherUp.val(data.teacher_id);
//             page.dialogs.elements.modalUpdateClass.modal('show');
//         })
//             .catch((error) => {
//                 console.log(error)
//             });
//     })
// }
//
// page.commands.addEventDeleteClick = () => {
//
//     $('.delete').on('click', function (message) {
//             classId = $(this).data('id');
//         console.log(classId)
//
//             if(confirm("Are you sure to delete this class?")){
//                 page.loadData.findClassById(classId).then((data) => {
//                     $.ajax({
//                         headers: {
//                             'accept': 'application/json',
//                             'content-type': 'application/json'
//                         },
//                         type: 'DELETE',
//                         url: page_url + '/' + classId,
//                     })
//                         .done((data) => {
//                             $('#tr_' + classId).remove();
//                             page.commands.removeAllEvent();
//                             page.commands.addEventClick();
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
//         url: 'http://127.0.0.1:3000/manager/teachers' + '/' + id
//     })
//         .done((data) => {
//
//         })
//         .fail((error) => {
//             console.log(error);
//         })
// }
//
// page.loadData.findClassById = (id) => {
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
//
// page.loadData.getAllClasses = () => {
//     $.ajax({
//         type: 'GET',
//         url: page_url,
//         dataType: 'json'
//     })
//         .done((data) => {
//             data.forEach(item => {
//                 page.loadData.findTeacherById(item.teacher_id).then((teacher) => {
//                     let str = renderClass(item, teacher);
//                     $("#class-table").append(str);
//                 })
//             });
//             page.commands.removeAllEvent();
//             page.commands.addEventClick();
//         })
//         .fail((error) => {
//             console.log(error);
//         })
// }
//
// page.loadData.getAllTeachers = () => {
//     $.ajax({
//         type: 'GET',
//         url: 'http://127.0.0.1:3000/manager/teachers',
//         dataType: 'json'
//     })
//         .done((data) => {
//             console.log(data)
//             page.dialogs.elements.teacherCre.empty();
//             page.dialogs.elements.teacherUp.empty();
//             $.each(data, (i, item) => {
//                 let str = renderTeacher(item);
//                 page.dialogs.elements.teacherCre.append(str);
//
//                 page.dialogs.elements.teacherUp.append(str);
//             })
//         })
//         .fail((error) => {
//             console.log(error);
//         })
//
// }
//
// function renderTeacher(obj) {
//     return `
//             <option value="${obj.id}">${obj.name}</option>
//             `;
// }
//
// function renderClass(student_class, teacher) {
//     return `<tr id="tr_${student_class.id}">
//                 <td>${student_class.id}</td>
//                 <td>${student_class.id}</td>
//                 <td>${student_class.name}</td>
//                 <td>${teacher.name}</td>
//                 <td>
//                     <button class="btn btn-primary show" data-id="${student_class.id}">Show</button>
//                 </td>
//                 <td>
//                     <button class="btn btn-warning edit" data-id="${student_class.id}">Edit</button>
//                 </td>
//                 <td>
//                     <button class="btn btn-danger delete" data-id="${student_class.id}">Delete</button>
//                 </td>
//             </tr>
//         `
// }
//
// page.commands.loadData = () => {
//     page.loadData.getAllClasses();
//     page.loadData.getAllTeachers();
// }
//
// page.initializeControlEvent = () => {
//
//     page.elements.btnShowCreateModal.on('click', () => {
//         $('#createForm')[0].reset();
//         page.dialogs.elements.modalCreateClass.modal('show');
//     })
//
//     page.dialogs.elements.btnCreate.on('click', function () {
//         page.dialogs.commands.doCreate();
//     });
//
//     page.dialogs.elements.btnUpdate.on('click', () => {
//         page.dialogs.commands.doUpdate();
//     })
//
// }
// $(() => {
//     page.commands.loadData();
//
//     page.initializeControlEvent();
// })
