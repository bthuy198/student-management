
$(".js-btn-add").on("click", function () {
     console.log("click");
     // $(".js-btn-add").off("click");
     addGradeField();
})

function addGradeField() {
     var length = $(".street-field").length;
     var div = document.createElement("div");
     div.className = "row"
     var input_subject = document.createElement("input");
     var input_score = document.createElement("input");
     var input_semester = document.createElement("input");
     var input_comments = document.createElement("input");

     var div_subject = document.createElement("div");
     div_subject.className = "col";
     input_subject.type = "text";
     input_subject.name = "student[grades_attributes][" + length + "][subject]"
     input_subject.className = "form-control street-field"
     input_subject.id = "student_grades_attributes_" + length + "_subject"
     div_subject.appendChild(input_subject)

     var div_score = document.createElement("div");
     div_score.className = "col";
     input_score.type = "text";
     input_score.name = "student[grades_attributes][" + length + "][score]"
     input_score.className = "form-control street-field"
     input_score.id = "student_grades_attributes_" + length + "_score"
     div_score.appendChild(input_score)

     var div_semester = document.createElement("div");
     div_semester.className = "col";
     input_semester.type = "text";
     input_semester.name = "student[grades_attributes][" + length + "][semester]"
     input_semester.className = "form-control street-field"
     input_semester.id = "student_grades_attributes_" + length + "_semester"
     div_semester.appendChild(input_semester)

     var div_comments = document.createElement("div");
     div_comments.className = "col";
     input_comments.type = "text";
     input_comments.name = "student[grades_attributes][" + length + "][comment]"
     input_comments.className = "form-control street-field"
     input_comments.id = "student_grades_attributes_" + length + "_comments"
     div_comments.appendChild(input_comments)


     //add created <li> element with its child elements 
     //(label and input) to myList (<ul>) element
     div.appendChild(div_subject)
     div.appendChild(div_score)
     div.appendChild(div_semester)
     div.appendChild(div_comments)
     $(".grade-container").append(div);
}

// $(".js-btn-add").on("click", function() {
//        console.log("click")
//   })