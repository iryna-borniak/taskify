import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  handleDeleteClick(event) {    
    const { target } = event;
    const taskWrapper = target.closest('.task-wrapper');
    
    taskWrapper.classList.add('hidden');
  }
}
