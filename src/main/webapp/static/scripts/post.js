function openImagePicker() {
    let imageUrl = prompt("Vui lòng nhập URL của hình ảnh:");

    if (imageUrl) {
        let contentDiv = document.getElementById("content");
        let imgTag = `<img src="${imageUrl}" alt="Hình ảnh" class="resizable">`;

        insertAtCaret(contentDiv, imgTag);
        enableResize();
    }
}

function insertAtCaret(element, html) {
    element.focus();
    if (window.getSelection) {
        let sel = window.getSelection();
        if (sel.getRangeAt && sel.rangeCount) {
            let range = sel.getRangeAt(0);
            range.deleteContents();


            let el = document.createElement("div");
            el.innerHTML = html;
            let frag = document.createDocumentFragment(), node, lastNode;
            while ((node = el.firstChild)) {
                lastNode = frag.appendChild(node);
            }
            range.insertNode(frag);


            if (lastNode) {
                range = range.cloneRange();
                range.setStartAfter(lastNode);
                range.collapse(true);
                sel.removeAllRanges();
                sel.addRange(range);
            }
        }
    }
}
function enableResize() {
    interact('.resizable')
        .draggable({
            onmove: function (event) {
                let target = event.target;


                let x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
                let y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;


                target.style.transform = `translate(${x}px, ${y}px)`;
                target.setAttribute('data-x', x);
                target.setAttribute('data-y', y);
            },
        })


    document.querySelectorAll('.resizable').forEach(img => {
        img.onload = function() {
            let aspectRatio = img.naturalHeight / img.naturalWidth;
            img.style.width = '600px';
            img.style.height = (600 * aspectRatio) + 'px';
        };


        if (img.complete) {
            img.onload();
        }
    });
}
