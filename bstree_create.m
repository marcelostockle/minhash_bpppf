function bstree = bstree_create(n)
  depth = 2 + nextpow2(n + 1);
  bstree.size = 2^depth - 1;
  
  bstree.root = 1;
  bstree.tree = zeros(bstree.size, 1);
  bstree.counts = zeros(bstree.size, 1);
  bstree.height = zeros(bstree.size, 1);
  bstree.lchild = zeros(bstree.size, 1);
  bstree.rchild = zeros(bstree.size, 1);
  bstree.nextchildren = [2 3];