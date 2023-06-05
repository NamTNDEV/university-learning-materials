function startLoading() {
    const loadingClass = 'loading';
    const loadingContainer = document.createElement('div');
    loadingContainer.classList.add('loading')
    loadingContainer.innerHTML = `
                                        <div class="spinner-border text-light" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>`
    document.body.appendChild(loadingContainer)
}

function stopLoading() {
    return document.querySelector('.loading')?.remove();
}
