const findInsertIndex = (array, search) => {
  let start = 0;
  let end = array.length - 1;

  while (start <= end) {
    let mid = Math.floor((start + end) / 2);

    if (array[mid] === search)
      return mid;

    else if (array[mid] < search)
      start = mid + 1;

    else
      end = mid - 1;
  }

  return end + 1;
}

export default findInsertIndex;
