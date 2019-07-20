import { Sortable } from "@shopify/draggable";

export default function ectoListSorting() {
  const containerSelector = ".StackedList";
  const containers = document.querySelectorAll(containerSelector);

  new Sortable(containers, {
    draggable: ".StackedListItem",
    mirror: {
      appendTo: containerSelector,
      constrainDimensions: true
    }
  });
}
