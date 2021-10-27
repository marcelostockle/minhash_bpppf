function queue = maxheap_adjust(queue, index, order)
  % Verifies whether an index in a max-heap doesn't violate the heap invariant
  % property.
  % 
  % Useful insights:
  % - In a binary max-heap
  % -- parent node = floor(i / 2)
  % -- child nodes = [2*i, 2*i+1]
  % - In a nth-order max heap
  % -- parent node = floor((i + n - 2) / n)
  % -- child nodes = (n*i-n+2):(n*i+1)
  %
  % - After an insertion, the heap invariant property can only be violated 
  %   between an insertion-parent or insertion-children, BUT NOT BOTH.
  if (nargin < 3)
    order = 2;
  endif
  
  parent = floor((i + n - 2) / n);
  children = (n*i - n + 2):(n*i + 1);
  
  aux = queue(index);
  if (parent > 0 && queue(index) > queue(parent))
    queue(index) = queue(parent);
    queue(parent) = aux;
    queue = maxheap_adjust(queue, parent, order);
  elseif (children(end) <= numel(queue))
    [~, maxchild] = max(queue(children))
    maxchild = children(maxchild);
    if (queue(maxchild) > queue(index))
      queue(index) = queue(maxchild);
      queue(maxchild) = aux;
      queue = maxheap_adjust(queue, maxchild, order);
    endif
  endif