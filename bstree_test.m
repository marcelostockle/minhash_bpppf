clear;
bstree = bstree_create(20);
[bstree, bstree.root] = bstree_insert(bstree, 40);
[bstree, bstree.root] = bstree_insert(bstree, 32);
[bstree, bstree.root] = bstree_insert(bstree, 34);
[bstree, bstree.root] = bstree_insert(bstree, 25);
[bstree, bstree.root] = bstree_insert(bstree, 31);
B = [bstree.counts bstree.tree bstree.height];
B(B(:,2)>0,:)