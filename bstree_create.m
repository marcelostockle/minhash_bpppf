function bstree = bstree_create(n)
  depth = 1 + nextpow2(n + 1);
  bstree.size = 2^depth - 1;
  
  bstree.root = 1;
  bstree.tree = zeros(bstree.size, 1);
  bstree.counts = zeros(bstree.size, 1);
  bstree.height = zeros(bstree.size, 1);
  bstree.lchild = 2 * (1:bstree.size)';
  bstree.rchild = 1 + 2 * (1:bstree.size)';