function [bstree, root] = bstree_balance(bstree, root)
  
  lchild = bstree.lchild(root);
  rchild = bstree.rchild(root);
  balance = bstree.height(rchild) - bstree.height(lchild);
  if (abs(balance) > 2)
    if (balance < 0)
      % Left side unbalanced. Right rotation
      [bstree, lchild] = bstree_balance(bstree, lchild);
      bstree.lchild(root) = lchild;
      bstree.height(root) = max(bstree.height(root), 1+bstree.height(lchild));
    else
      % Right side unbalanced. Left rotation
      [bstree, rchild] = bstree_balance(bstree, rchild);
      bstree.rchild(root) = rchild;
      bstree.height(root) = max(bstree.height(root), 1+bstree.height(rchild));
    endif
  elseif (abs(balance) == 2)
    if (balance < 0)
      % Left side unbalanced. Right rotation
      bstree.lchild(root) = bstree.rchild(lchild);
      bstree.rchild(lchild) = root;
      bstree.height(root) = 1 + max(bstree.height(rchild), bstree.height(bstree.lchild(root)));
      bstree.height(lchild) = max(bstree.height(lchild), 1+bstree.height(root));

      % What if the former root node no longer has any children
      if (bstree.counts(bstree.lchild(root)) == 0 && bstree.counts(bstree.rchild(root)) == 0)
        bstree.height(root) = 0;
      endif
      
      root = lchild;
    else
      % Right side unbalanced. Left rotation
      bstree.rchild(root) = bstree.lchild(rchild);
      bstree.lchild(rchild) = root;
      bstree.height(root) = 1 + max(bstree.height(lchild), bstree.height(bstree.rchild(root)));
      bstree.height(rchild) = max(bstree.height(rchild), 1+bstree.height(root));
      
      % What if the former root node no longer has any children
      if (bstree.counts(bstree.lchild(root)) == 0 && bstree.counts(bstree.rchild(root)) == 0)
        bstree.height(root) = 0;
      endif
      
      root = rchild;
    endif
  endif
