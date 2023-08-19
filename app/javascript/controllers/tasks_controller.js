import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  
  connect() {
    this.updateNotCompletedCount();
  }

  toggle(event) {
    const { target } = event;
    const id = target.dataset.id;
    const descriptionDiv = target.closest('form').querySelector('.description');
    const taskWrapper = target.closest('.task-wrapper');     
    const currentPath = window.location.pathname;

    this.updateNotCompletedCount();    
    this.toggleDescriptionStyle(descriptionDiv, target.checked);
    this.toggleTaskVisibility(taskWrapper, currentPath, target.checked);    
    this.updateTaskStatus(id, target.checked);   
  }
  
  toggleDescriptionStyle(descriptionDiv, isChecked) {
    if (isChecked) {
      descriptionDiv.classList.add('line-through');
    } else {
      descriptionDiv.classList.remove('line-through');
    }
  }

  toggleTaskVisibility(taskWrapper, currentPath, isChecked) {
    if (currentPath === '/tasks/not_completed' && isChecked) {
      taskWrapper.classList.add('hidden');
    } else if (currentPath === '/tasks/completed' && !isChecked) {
      taskWrapper.classList.add('hidden');
    } else {
      taskWrapper.classList.remove('hidden');
    }
  }

  async updateTaskStatus(id, completed) {
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    try {
      const response = await fetch(`/tasks/${id}/toggle`, {
        method: 'POST',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken,
        },
        body: JSON.stringify({ completed }),
      });

      const data = await response.json();
      console.log(data.message);
      
    } catch (error) {
      console.error('Error updating task status:', error);
    }
  }
  
  async updateNotCompletedCount() {
    const notCompletedCountSpan = document.getElementById('not_completed_count');

    try {
      const response = await fetch('/tasks/not_completed_count', {
        method: 'GET',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const data = await response.json();
      const count = data.count;
      
      const countText = count === 1 ? 'task' : 'tasks';
      notCompletedCountSpan.innerText = `${count} ${countText}`;      
    } catch (error) {
      console.error('Error updating not completed count:', error);
    }
  }
}
