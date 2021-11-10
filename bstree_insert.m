function [bstree, root] = bstree_insert(bstree, entry, root)
  if (nargin < 3)
    root = bstree.root;
  endif
  
  lchild = bstree.lchild(root);
  rchild = bstree.rchild(root);
  if (bstree.counts(root) == 0)
    bstree.counts(root)++;
    bstree.tree(root) = entry;
    bstree.height(root) = 0;
  elseif (lchild <= bstree.size && rchild <= bstree.size)
    if (entry < bstree.tree(root))
      [bstree, lchild] = bstree_insert(bstree, entry, lchild);
      bstree.lchild(root) = lchild;
      bstree.height(root) = max(bstree.height(root), 1+bstree.height(lchild));
      [bstree, root] = bstree_balance(bstree, root);
    elseif (entry > bstree.tree(root))
      [bstree, rchild] = bstree_insert(bstree, entry, rchild);
      bstree.rchild(root) = rchild;
      bstree.height(root) = max(bstree.height(root), 1+bstree.height(rchild));
      [bstree, root] = bstree_balance(bstree, root);
    else
      bstree.counts(root)++;
    endif
  else
    printf("Tree overflow. Failed to insert %d.\n", entry)
  endif
