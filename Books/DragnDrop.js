const draggables = document.querySelectorAll('.draggable')
const containers = document.querySelectorAll('.sortContainer')

draggables.forEach(draggable => {
  draggable.addEventListener('dragstart', () => {
    draggable.classList.add('dragging')
  })

  draggable.addEventListener('dragend', () => {
    draggable.classList.remove('dragging')
  })
})

containers.forEach(container => {
  container.addEventListener('dragover', e => {
    e.preventDefault()
    const afterElement = getDragAfterElement(container, e.clientY)
    const draggable = document.querySelector('.dragging')
    if (afterElement == null) {
      container.appendChild(draggable)
    } else {
      container.insertBefore(draggable, afterElement)
    }
  })
})

function getDragAfterElement(container, y) {
  const draggableElements = [...container.querySelectorAll('.draggable:not(.dragging)')]

  return draggableElements.reduce((closest, child) => {
    const box = child.getBoundingClientRect()
    const offset = y - box.top - box.height / 2
    if (offset < 0 && offset > closest.offset) {
      return {
        offset: offset,
        element: child
      }
    } else {
      return closest
    }
  }, {
    offset: Number.NEGATIVE_INFINITY
  }).element
}

function getNewOrder(container, y) {
  const newDraggableElements = [...document.querySelectorAll('.draggable')];
  const newInputArray = [...document.querySelectorAll('.sortable')];

  newInputArray.forEach((inputel, index) => {
    const inputID = index + 1;
    const newName = 'StoryID' + inputID;
    inputel.setAttribute('name', newName);
  })
  console.log(newDraggableElements);
}