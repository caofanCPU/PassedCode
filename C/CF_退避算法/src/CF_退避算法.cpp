		/*						********二元指数后退算法介绍********
		在CSMA/CD协议中，一旦检测到冲突，为降低再冲突的概率，需要等待一个随机时间，然后再使用CSMA方法试图传输。
		为了保证这种退避维持稳定，采用了二进制指数退避算法的技术，其算法过程如下：
		1. 将冲突发生后的时间划分为长度为T的时隙
		2. 发生第一次冲突后，各个站点等待0或1个时隙再开始重传
		3. 发生第二次冲突后，各个站点随机地选择等待0，1，2或3个时隙再开始重传
		4. 第i(i<=10)次冲突后，在0至(2^i-1)间随机地选择一个等待的时隙数，再开始重传
		5. 10次冲突后，选择等待的时隙数固定在0至1023（2的10次方减一）间
		6. 16次冲突后，发送失败，报告上层。
		*/

/********************************************************************
 *	二元指数后退算法程序(Binary Exponential Backoff program)-源码
 *	
 *	源文件名：CF_退避算法.c
 *  程序功能：二进制后退算法的C语言实现
 *  程序参数：用户键盘正确输入争用期T和重传次数K
 *	创建日期：2015-3-23
 *	作者    ：曹  繁
 *  邮箱    ：2804238230@qq.com
 *	V 1.3
 *	若明诸葛若风皎月 @ Copyright
********************************************************************/

#include <stdio.h>
#include <time.h>
#include <math.h>
#include <windows.h>				//头文件声明
int main()
{
	int K,s;						//重传次数K,随机时隙个数取值s
	float T,Tm;						//争用期存储变量T,延迟时间存储变量Tm
	char w;							//容错字符变量w
	srand((unsigned) time(NULL));	//初始化随机种子
	printf("****Welcome to use Binary Exponential Backoff program!****\n\n\n");				//提示欢迎信息
	printf("Please input a decimals as Contention Period(争用期):\t");						//提示输入“争用期”信息
	scanf("%f",&T);					//用户输入的争用期赋值给变量T
	scanf("%c",&w);					//Enter键被过滤掉，不影响后面的输入取值
	printf("\nPlease input an integer range 0 to 16 as Retransmission(重传次数):\t");		//提示输入“重传次数”信息
	scanf("%d",&K);					//用户输入的重传次数赋值给变量K
    scanf("%c",&w);					//Enter键被过滤掉，不影响后面的输入取值
	if(K<16)
	{
		if(K<10)
		{
			s=(int)pow(2,K);
			s=rand()%s;	//时隙取值为0到(2^K-1)之间的整数
		}
		else
		{
			s=(int)pow(2,10);
			s=rand()%s;
		}
		Tm=T*s;												 //计算T,K,s情况下的推迟时间Tm
		printf("\n****In the condition: T=%8.3f微秒, K=%d次 got: s=%d个\n",T,K,s);  
		printf("****The Delay time is %-8.3f微秒\n\n",Tm);								//输出结果
	}
	else
	{
		printf("\n传送失败!  Reason:打算同时发送数据的站太多,以致连续发生冲突,应丢弃该数据帧!\n\n");
	}
	system("pause");										//开启“请按任意键结束程序”功能
	system("cls");											//清屏操作
	main();													//重复执行主函数main(),便于重复测试
	return 0;
}