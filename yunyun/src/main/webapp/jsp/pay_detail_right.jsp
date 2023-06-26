<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	
	------- 자동생성
	예약 요청 일자
	예약날짜
	예약자명
	연락처
	구장 이름
	구장 주소
	구장 이미지
	금액
	
	------- 환불 및 주의 사항
	안내사항

	------- 버튼
	뒤로가기 / 결제하기
	
	
-->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	/* Basic Style */
body {
  background: #fff;
  color: #333;
  font-family: Lato, sans-serif;
}
.container {
  display: block;
  width: 400px;
  margin: 100px auto 0;
}
ul {
  margin: 0;
  padding: 0;
}
li * {
  float: left;
}
li, h3 {
  clear:both;
  list-style:none;
}
input, button {
  outline: none;
}
button {
  background: red;
  border: none;
  color: white;
  font-size: 15px;
  width: 370px;
  height: 50px;
  margin: 0 auto;
  font-family: Lato, sans-serif;
  cursor: pointer;
  border-radius: 25px;
  text-align: center;
}

button:hover {
  color: #333;
}
/* Heading */
h3,
label[for='new-task'] {
  color: #333;
  font-weight: 700;
  font-size: 15px;
  border-bottom: 2px solid #333;
  padding: 30px 0 10px;
  margin: 0;
  text-transform: uppercase;
}

input[type="text"] {
  margin: 0;
  font-size: 18px;
  line-height: 18px;
  height: 18px;
  padding: 10px;
  border: 1px solid #ddd;
  background: #fff;
  border-radius: 6px;
  font-family: Lato, sans-serif;
  color: #888;
}
input[type="text"]:focus {
  color: #333;
}

/* New Task */
label[for='new-task'] {
  display: block;
  margin: 0 0 20px;
}
input#new-task {
  float: left;
  width: 318px;
}
p > button:hover {
  color: #0FC57C;
}

/* Task list */
li {
  overflow: hidden;
  padding: 20px 0;
  border-bottom: 1px solid #eee;
}

li > label {
  font-size: 18px;
  line-height: 40px;
  width: 237px;
  padding: 0 0 0 11px;
}
li >  input[type="text"] {
  width: 226px;
}
li > .delete:hover {
  color: #CF2323;
}



/* Edit Task */
ul li input[type=text] {
  display:none;
}

ul li.editMode input[type=text] {
  display: block;
  margin: 0 0 20px;
  width:80%;
}

ul li.editMode label {
  display:none;
}



<!-- 버튼 -->
#payBtn {
    border: 1px solid black;
    position: absolute;
    top: 50%;
    right: 0;
}


</style>

<script type="text/javascript">
//Problem: User interaction doesn't provide desired results.
//Solution: Add interactivity so the user can manage daily tasks

var taskInput = document.getElementById("new-task");
var addButton = document.getElementsByTagName("button")[0];
var incompleteTasksHolder = document.getElementById("incomplete-tasks");
var completedTasksHolder = document.getElementById("completed-tasks");

//New Task List Item
var createNewTaskElement = function(taskString) {
//Create List Item
var listItem = document.createElement("li");

//input (checkbox)
var checkBox = document.createElement("input"); // checkbox
//label
var label = document.createElement("label");
//input (text)
var editInput = document.createElement("input"); // text
//button.edit
var editButton = document.createElement("button");
//button.delete
var deleteButton = document.createElement("button");

   //Each element needs modifying

checkBox.type = "checkbox";
editInput.type = "text";

editButton.innerText = "Edit";
editButton.className = "edit";
deleteButton.innerText = "Delete";
deleteButton.className = "delete";

label.innerText = taskString;

 
   // each element needs appending
listItem.appendChild(checkBox);
listItem.appendChild(label);
listItem.appendChild(editInput);
listItem.appendChild(editButton);
listItem.appendChild(deleteButton);

return listItem;
}

//Add a new task
var addTask = function() {
console.log("Add task...");
//Create a new list item with the text from #new-task:
var listItem = createNewTaskElement(taskInput.value);
//Append listItem to incompleteTasksHolder
incompleteTasksHolder.appendChild(listItem);
bindTaskEvents(listItem, taskCompleted);  

taskInput.value = "";   
}

//Edit an existing task
var editTask = function() {
console.log("Edit Task...");

var listItem = this.parentNode;

var editInput = listItem.querySelector("input[type=text]")
var label = listItem.querySelector("label");

var containsClass = listItem.classList.contains("editMode");
 //if the class of the parent is .editMode 
if(containsClass) {
   //switch from .editMode 
   //Make label text become the input's value
 label.innerText = editInput.value;
} else {
   //Switch to .editMode
   //input value becomes the label's text
 editInput.value = label.innerText;
}

 // Toggle .editMode on the parent
listItem.classList.toggle("editMode");

}


//Delete an existing task
var deleteTask = function() {
console.log("Delete task...");
var listItem = this.parentNode;
var ul = listItem.parentNode;

//Remove the parent list item from the ul
ul.removeChild(listItem);
}

//Mark a task as complete 
var taskCompleted = function() {
console.log("Task complete...");
//Append the task list item to the #completed-tasks
var listItem = this.parentNode;
completedTasksHolder.appendChild(listItem);
bindTaskEvents(listItem, taskIncomplete);
}

//Mark a task as incomplete
var taskIncomplete = function() {
console.log("Task Incomplete...");
// When checkbox is unchecked
// Append the task list item #incomplete-tasks
var listItem = this.parentNode;
incompleteTasksHolder.appendChild(listItem);
bindTaskEvents(listItem, taskCompleted);
}

var bindTaskEvents = function(taskListItem, checkBoxEventHandler) {
console.log("Bind list item events");
//select taskListItem's children
var checkBox = taskListItem.querySelector("input[type=checkbox]");
var editButton = taskListItem.querySelector("button.edit");
var deleteButton = taskListItem.querySelector("button.delete");

//bind editTask to edit button
editButton.onclick = editTask;

//bind deleteTask to delete button
deleteButton.onclick = deleteTask;

//bind checkBoxEventHandler to checkbox
checkBox.onchange = checkBoxEventHandler;
}

var ajaxRequest = function() {
console.log("AJAX Request");
}

//Set the click handler to the addTask function
//addButton.onclick = addTask;
addButton.addEventListener("click", addTask);
addButton.addEventListener("click", ajaxRequest);


//Cycle over the incompleteTaskHolder ul list items
for(var i = 0; i <  incompleteTasksHolder.children.length; i++) {
 // bind events to list item's children (taskCompleted)
bindTaskEvents(incompleteTasksHolder.children[i], taskCompleted);
}
//Cycle over the completeTaskHolder ul list items
for(var i = 0; i <  completedTasksHolder.children.length; i++) {
 // bind events to list item's children (taskIncompleted)
bindTaskEvents(completedTasksHolder.children[i], taskIncomplete); 

}



</script>
	
</head>
<body>

<body>
    <div class="container">
      <p>
        <label for="new-task">구장 이름</label><input id="new-task" type="text">
      </p>
      
      <h3>예약 정보</h3>
      <ul>
 		<li class="editMode"><input type="text" value="예약일자 띄우기"></li>
        <li class="editMode"><input type="text" value="예약시간 띄우기"></li>
      </ul>
      
      <h3>총 금액(VAT 포함)</h3>
      <ul>
        <li><label><strong>100,000원</strong></label><input type="text"></li>
      </ul>
      
      <ul>
        <li><label><button type="button" id="payBtn">결제하기</button></label></li>
      </ul>
    </div>
   

    <script type="text/javascript" src="js/app.js"></script>



</body>
</html>