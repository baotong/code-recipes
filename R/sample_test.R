n=20000 #计算n次展现，每次展现16个广告
m=1000 #每次展现从1000条广告里面取
setwd("~/work/test/R")
a=read.table("ecpm.txt") #ecpm，共四列，分别为4个类目
a=-apply(-a,2,sort)  #将广告按ecpm从高到低排序

p=a[,1] #选择其中一个类目来做模拟，类目为16 50010850
p1=p/sum(p)

#方案一，直接用sample命令每次从1000个广告里无放回的抽取16个。
z1=matrix(0,n,m)
for(i in 1:n)
{ 
  #set.seed(i)
  t=sample(1:m, 16, replace=FALSE,prob=p1)
  z1[i,t]=1
}

pv1=apply(z1,2,sum)


#方案二：用算法同学提供的计算方法抽取
z2=matrix(0,n,m)
for(i in 1:n)
{
  #set.seed(i) 
  u=runif(m);
  p2=u^(10/p)
  t=order(-p2)[1:16]
  z2[i,t]=1
}

pv2 <- apply(z2,2,sum)

#比较两种算法的效果
plot(pv1,type="l",main="类目为16 50010850",xlab="ecpm",ylab="PV")
lines(pv2,col=2)


-sort(-pv1)[1:10]
-sort(-pv2)[1:10]
