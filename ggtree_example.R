# 首先，我们通过多序列比对软件以及进化树构建软件来得到nwk这个常用的树文件。
# 我们使用ggtree包来实现进化树可视化以及一定程度的美化
#安装及载入ggtree，treeio，ggplot2这3个包
library(ggplot2)
library(ggtree)
library(cowplot)
library(ggnewscale)

#读取nwk树文件
tree <- read.newick("nramp.nwk")
#可视化树文件,用环形树来显示
p1 <- ggtree(tree, layout = "circular", branch.length = "none")
#打印进化树
print(p1)
#如果去掉branch.length = "none"参数，重新可视化
p2 <- ggtree(tree, layout = "circular")
print(p2)

#添加tiplab
p3 <- p1 + geom_tiplab2(color="seagreen", size = 3, hjust = -.1)+xlim(NA, 22)
#打印进化树
print(p3)
#显示进化树的节点ID，为了后面的进一步修饰
p4 <- p3 + geom_text2(aes(label=node))
print(p4)
#为一部分树添加背景颜色，着重显示
p5 <- p3 + geom_hilight(node = 33, fill = "steelblue", alpha = 0.6)
print(p5)
plot_grid(p1, p2, p3, p4 ,p5, ncol=3, labels=c("A","B", "C", "D", "E"))
#------------------------------
#如果去掉branch.length = "none"参数，重新可视化
p1 <- ggtree(tree, layout = "circular")
#打印进化树
print(p1)
#为一部分树添加背景颜色，着重显示
p3 <- p1 + geom_hilight(node = 33, fill = "steelblue")
print(p3)

p6 <- ggtree(tree, layout = "circular", branch.length = "none")+geom_tiplab2(color = "seagreen",  size=3, hjust=-.05)+ xlim(NA, 20)# + geom_text2(aes(subset = !isTip, label=label, color="black"))
p61 <- ggtree(tree, layout = "circular", branch.length = "none", )+geom_tiplab2(color = "red",  size=2, hjust=-.1)+ xlim(NA, 20)
print(p6)
print(p61)
plot_grid(p6, p61, ncol = 2, labels = c("F","G"))
p7 <- p6 + geom_strip(14, 17, barsize = 3, color = "steelblue", offset = 7, label = "Clade I", offset.text = 1, angle = 60, fontsize = 4, hjust = "center", extend = 0.3) + geom_strip(11, 13, color = "red", barsize = 3, offset = 7, label = "Clade II", offset.text = 1, angle = -15, fontsize = 4, hjust = "center", extend = 0.3) + geom_strip(6, 9, color = "orange", barsize = 3, offset = 7, label = "Clade III", offset.text = 1, angle = 10, fontsize = 4, hjust = "center", extend = 0.3)
p7

#让进化树着色，变成自己需要的颜色。先根据节点，构建自己的颜色数据框
d <- read.csv("/Users/lxmic/Desktop/nramp_color.csv", header = TRUE)
d <- data.frame(d)
#使用%<+%符号强插入颜色数据到树文件中
p8 <- p7%<+%d + aes(color = I(color))
print(p8)
