// LifeGame.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//作者：息震，3180102653；修彦名，3180105769。
//编译环境：Visual Studio 2017
//使用了开源的EasyX绘图库

// 运行程序: Ctrl + F5 或调试 >“开始执行(不调试)”菜单
// 调试程序: F5 或调试 >“开始调试”菜单
// 入门提示: 
//   1. 使用解决方案资源管理器窗口添加/管理文件
//   2. 使用团队资源管理器窗口连接到源代码管理
//   3. 使用输出窗口查看生成输出和其他消息
//   4. 使用错误列表窗口查看错误
//   5. 转到“项目”>“添加新项”以创建新的代码文件，或转到“项目”>“添加现有项”以将现有代码文件添加到项目
//   6. 将来，若要再次打开此项目，请转到“文件”>“打开”>“项目”并选择 .sln 文件

#include "pch.h"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <graphics.h>
#include <Windows.h>
#include <time.h>
#include <tchar.h>
#include <mmsystem.h>

#pragma comment(lib,"Winmm.lib")	//引用Windows Multimedia API。

#define width 1160		//绘图界面之宽度。
#define height 720		//绘图界面之高度。
#define Iwidth 20		//方块的宽度。
#define Iheight 20		//方块的高度。
#define Tsize 20		//文字的基准大小。
#define ColorOfLife   RGB(115,184,577)	//个体色。
#define ColorOfTemple RGB(156,39,176)	//神庙色。
#define ColorOfWater  RGB(0,127,255)	//水色。
#define BKColor       RGB(0,191,255)	//背景色。
#define ColorOfFire   RGB(229,90,16)	//煷色。
#define upper 500		//动物上位数量。
#define upper1 200		//水的上位数量。
#define downer 400		//动物下位数量。
#define downer1 100		//水的下位数量。

//初始化结构和全局数组。
struct Block	//方块的结构体。IsWater是水源，IsLife是生命单位；IsTemple是神庙；Water水量。
{
	bool IsWater;
	bool IsLife;
	bool IsTemple;
	unsigned int Water;
};

Block units[width / Iwidth + 1][height / Iheight - 1];		//方块的结构体。IsWater是水源，IsLife是生命单位；IsTemple是神庙；Water水量。
Block units2[width / Iwidth + 1][height / Iheight - 1]; 	//IsWater是水源，IsLife是生命单位；IsTemple是神庙；Water水量。用于隔离前后单位。

//初始化全局变量。
bool stop = false;			//停止之标志。
unsigned int water = 0;		//玩家所持水量。
unsigned short fire = 3;	//玩家剩余发射数。
unsigned short plays = 30;	//玩家还能进行的局数。
unsigned short Number = 0;	//场上剩余个体数。
bool cheater = false;		//是否进行了作弊操作。
bool IsMusicTwo = false;	//是否发生了音乐切换。
bool IsRead = false;		//是否发生了读档。

MOUSEMSG mmsg;				//定义鼠标消息。

//声明函数。
void Initialization();										//初始化。
void Screen();												//显示。
void UpdateWithoutInput();									//自动演化。
void UpdateWithInput();										//玩家干涉。
void startingscene();										//开头的过场对话。
void dialogue(RECT *r, TCHAR *s);							//过场对话的每一句。
void WaterSet();											//加水。
void LifeSet();												//初始生命设定。
void hint();												//过程中的对话栏和提示/数据栏。
void cutscene();											//结束的过场对话。
void gameover();											//结果清算，结束画面。
void Fire(int x, int y);									//发射清理。
void BoardInput(unsigned short *WaterAdd, int x, int y);	//使用新窗口输入。
void TcharToChar(const TCHAR * tchar, char * _char);		//将TCHAR转为char。
void DoFire();												//清理。
void movie();												//乱码和连接动画。
void SaveFile();											//保存存档。
void Read_File();											//读取存档。

using namespace std;

int main()
{
	mciSendString(L"open .\\b.mp3 alias bkmusic1", NULL, 0, NULL);	//播放音乐。
	mciSendString(_T("play bkmusic1 repeat"), NULL, 0, NULL);

	srand((unsigned int)time(NULL));	//设置种子。
	initgraph(width, height);			//Initializing graphing window;

	Initialization();					//开头。

	while (1)
	{
		UpdateWithoutInput();			//演化。
		Screen();						//显示结果。
		UpdateWithInput();				//进行干涉。

		setbkcolor(BKColor);			//清屏。
		setbkmode(TRANSPARENT);
		cleardevice();

		if (stop == true)				//停止条件。
			break;						//停止。
	}

	gameover();							//结果清算，结束画面。
	closegraph();						//用不到的，就是为了规范性。
	return 0;							//同上。
}

//初始化。
void Initialization()
{
	HWND hwnd = GetHWnd();											//获取窗口句柄。
	SetWindowText(hwnd, _T("你好"));								//改窗口名称。

	movie();														//开头动画。

	setbkcolor(BKColor);											//设置背景为背景色并清屏。
	setbkmode(TRANSPARENT);
	cleardevice();

	startingscene();												//开头过场对话。
	stop = false;													//重新初始化stop。
	if (IsRead == true)
	{
		mciSendString(_T("stop bkmusic1"), NULL, 0, NULL);	//关闭音乐。
		mciSendString(_T("close bkmusic1"), NULL, 0, NULL);
		mciSendString(L"open .\\a.mp3 alias bkmusic", NULL, 0, NULL);	//播放音乐。
		mciSendString(_T("play bkmusic repeat"), NULL, 0, NULL);
		return;
	}

	setlinecolor(WHITE);											//设置格子线条颜色。
	setfillcolor(BKColor);											//设置格子填充颜色。是背景色。

	for (int i1 = 0; i1 <= width / Iwidth; i1++)						//初始化结构。临时画图。
	{
		for (int i2 = 0; i2 <= height / Iheight - 2; i2++)
		{
			units[i1][i2].IsWater = false;
			units2[i1][i2].IsWater = false;
			units[i1][i2].IsLife = false;
			units2[i1][i2].IsLife = false;
			units[i1][i2].IsTemple = false;
			units2[i1][i2].IsTemple = false;
			units[i1][i2].Water = 0;
			units2[i1][i2].Water = 0;
			if (i1 > 0 && i2 > 0)
			{
				fillrectangle(Iwidth*(i1 - 1), Iheight*(i2 - 1), Iwidth*(i1), Iheight*i2);	//显示格子边框。
			}

		}
	}

	mciSendString(_T("stop bkmusic1"), NULL, 0, NULL);	//关闭音乐。
	mciSendString(_T("close bkmusic1"), NULL, 0, NULL);
	mciSendString(L"open .\\a.mp3 alias bkmusic", NULL, 0, NULL);	//播放音乐。
	mciSendString(_T("play bkmusic repeat"), NULL, 0, NULL);

	water = 20;	//初始水量。

	RECT r = { 0,height - 2 * Iheight,width,height - Iheight };		//是文字对话栏。

	settextcolor(WHITE);	//设定字体颜色。

	//选定神庙。
	settextstyle(Tsize, 0, _T("宋体"));
	drawtext(_T("请选择“神庙”的位置"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);	//提示。
	settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
	outtextxy(0, height - Tsize, _T("鼠标左键单击某处以建立“神庙”。"));				//提示。
	while (1)
	{
		mmsg = GetMouseMsg();				//获取鼠标消息。
		if (mmsg.uMsg == WM_LBUTTONDOWN)	//若左键按下。
		{
			int x = mmsg.x;		//鼠标位置。
			int y = mmsg.y;
			x = x / Iwidth + 1;	//格子标号。
			y = y / Iheight + 1;

			if (x <= width / Iwidth && y <= height / Iheight - 2)	//不超出范围。
			{
				units[x][y].IsTemple = true;											//这里有神庙。
				units2[x][y].IsTemple = true;											//这里有神庙。
				setfillcolor(ColorOfTemple);											//设为神庙色。
				fillrectangle(Iwidth*(x - 1), Iheight*(y - 1), Iwidth*(x), Iheight*y);	//显示神庙。
			}
			break;
		}
	}
	clearrectangle(0, height - 2 * Iheight, width, height);	//清空对话栏和提示/数据栏。

	WaterSet();	//设定水。
	LifeSet();	//设定初始生命。

	return;
}

//显示。
void Screen()
{
	setbkcolor(BKColor);		//用背景色清屏。
	setbkmode(TRANSPARENT);
	cleardevice();

	BeginBatchDraw();			//开始批量绘图。

	for (int i1 = 0; i1 <= width / Iwidth; i1++)		//遍历各单元，绘图。
	{
		for (int i2 = 0; i2 <= height / Iheight - 2; i2++)
		{
			if (units[i1][i2].IsWater == true)			//画水。
			{
				setfillcolor(ColorOfWater);
				solidrectangle(Iwidth*(i1 - 1), Iheight*(i2 - 1), Iwidth*(i1), Iheight*i2);
				if (units[i1][i2].IsLife == true)		//画水中的小家伙。
				{
					setfillcolor(ColorOfLife);
					fillrectangle(Iwidth*(i1 - 1) + Iwidth / 4, Iheight*(i2 - 1) + Iheight / 4, Iwidth*(i1)-Iwidth / 4, Iheight*i2 - Iheight / 4);
				}
			}
			else if (units[i1][i2].IsLife == true)		//画生命个体。
			{
				setfillcolor(ColorOfLife);
				solidrectangle(Iwidth*(i1 - 1), Iheight*(i2 - 1), Iwidth*(i1), Iheight*i2);
			}
			else if (units[i1][i2].IsTemple == true)	//画神庙。
			{
				setfillcolor(ColorOfTemple);
				solidrectangle(Iwidth*(i1 - 1), Iheight*(i2 - 1), Iwidth*(i1), Iheight*i2);
			}
			else										//画空格子。
			{
				setfillcolor(BKColor);
				solidrectangle(Iwidth*(i1 - 1), Iheight*(i2 - 1), Iwidth*(i1), Iheight*i2);
			}
		}
	}

	hint();			//下方提示栏。

	EndBatchDraw();	//结束批量绘图。

	return;
}

//下方提示栏。
void hint()
{
	RECT r1 = { 0,height - 2 * Iheight,width,height - Iheight };		//对话栏。
	RECT r2 = { 0,height - Iheight,width,height };						//提示/数据栏。

	Number = 0;												//初始化Number。
	for (int i1 = 0; i1 <= width / Iwidth; i1++)			//遍历各单元，计数。
	{
		for (int i2 = 0; i2 <= height / Iheight - 2; i2++)
		{
			if (units[i1][i2].IsLife == true)
			{
				Number = Number + 1;
			}
		}
	}

	settextcolor(WHITE);				//设置字体样式。
	settextstyle(Tsize, 0, _T("宋体"));
	//输出。
	TCHAR s[100];
	swprintf_s(s, _T("现有水量：%hu	现有个体数：%hu	剩余清理次数：%hu	剩余天数：%hu"), water, Number, fire, plays);
	drawtext(s, &r2, DT_CENTER | DT_VCENTER | DT_SINGLELINE | DT_EXPANDTABS);
	drawtext(_T("C45型管理器，欢迎您。"), &r1, DT_CENTER | DT_VCENTER | DT_SINGLELINE);

	if (Number == 0)	//如果出现事故，即玩家把个体全部清光了，则无视plays变量，直接结束。
	{
		stop = true;
	}

	return;
}

//演化。
void UpdateWithoutInput()
{
	//注意，孤独是无法依靠水源抵挡的。一个个体会贪婪地从对它有效果的所有水源中吸水。

	for (int i1 = 1; i1 <= width / Iwidth; i1++)			//初始化units2。i1是横坐标，i2是纵坐标。
	{
		for (int i2 = 1; i2 <= height / Iheight - 2; i2++)
		{
			units2[i1][i2].IsWater = units[i1][i2].IsWater;
			units2[i1][i2].IsLife = units[i1][i2].IsLife;
			units2[i1][i2].IsTemple = units[i1][i2].IsTemple;
			units2[i1][i2].Water = units[i1][i2].Water;
		}
	}

	for (int i1 = 1; i1 <= width / Iwidth; i1++)			//遍历各单元，演化。
	{
		for (int i2 = 1; i2 <= height / Iheight - 2; i2++)
		{
			//第一级演化。
			//不考虑水源和神庙时，周围个体多于3个的和少于2个的，死亡。
			if (((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) >= 4) ||
				((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) <= 1))
			{
				units2[i1][i2].IsLife = false;
			}	//不考虑水源和神庙时，周围个体为2个的，生成。
			else if ((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) == 2)
			{
				units2[i1][i2].IsLife = true;
			}	//不考虑水源和神庙时，周围个体为3个的，保持。
			else
			{
				units2[i1][i2].IsLife = units[i1][i2].IsLife;
			}

			//第二级演化。
			//考量水源，当周围一圈有且仅有少于100的水源时，周围个体为4个的，保持（即撤销它的死亡）。
			if (((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) == 4) &&
				((units[i1 - 1][i2 - 1].IsWater + units[i1][i2 - 1].IsWater + units[i1 + 1][i2 - 1].IsWater + units[i1 - 1][i2].IsWater + units[i1 + 1][i2].IsWater + units[i1 - 1][i2 + 1].IsWater + units[i1][i2 + 1].IsWater + units[i1 + 1][i2 + 1].IsWater + units[i1][12].IsWater) > 0) &&
				(units[i1 - 1][i2 - 1].Water < 100 && units[i1][i2 - 1].Water < 100 && units[i1 + 1][i2 - 1].Water < 100 && units[i1 - 1][i2].Water + units[i1 + 1][i2].Water < 100 && units[i1 - 1][i2 + 1].Water < 100 && units[i1][i2 + 1].Water < 100 && units[i1 + 1][i2 + 1].Water < 100 && units[i1][12].Water < 100))
			{
				units2[i1][i2].IsLife = units[i1][i2].IsLife;
			}

			//考量水源，当周围一圈有大于等于100的水源时，周围个体多于3个的，保持(即撤销它的死亡)。
			if (((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) >= 4) &&
				((units[i1 - 1][i2 - 1].IsWater + units[i1][i2 - 1].IsWater + units[i1 + 1][i2 - 1].IsWater + units[i1 - 1][i2].IsWater + units[i1 + 1][i2].IsWater + units[i1 - 1][i2 + 1].IsWater + units[i1][i2 + 1].IsWater + units[i1 + 1][i2 + 1].IsWater + units[i1][12].IsWater) > 0) &&
				(units[i1 - 1][i2 - 1].Water >= 100 && units[i1][i2 - 1].Water >= 100 && units[i1 + 1][i2 - 1].Water >= 100 && units[i1 - 1][i2].Water + units[i1 + 1][i2].Water >= 100 && units[i1 - 1][i2 + 1].Water >= 100 && units[i1][i2 + 1].Water >= 100 && units[i1 + 1][i2 + 1].Water >= 100 && units[i1][12].Water >= 100))
			{
				units2[i1][i2].IsLife = units[i1][i2].IsLife;
			}

			//考量神庙，当周围二圈有神庙时，周围个体多于3个的和少于2个的，保持（即撤销它的死亡）。
			if ((((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) >= 4) ||
				((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) <= 1)) &&
				((units[i1 - 1][i2 - 1].IsTemple + units[i1][i2 - 1].IsTemple + units[i1 + 1][i2 - 1].IsTemple + units[i1 - 1][i2].IsTemple + units[i1 + 1][i2].IsTemple + units[i1 - 1][i2 + 1].IsTemple + units[i1][i2 + 1].IsTemple + units[i1 + 1][i2 + 1].IsTemple + units[i1][i2].IsTemple +
					units[i1 - 2][i2 - 2].IsTemple + units[i1 - 1][i2 - 2].IsTemple + units[i1][i2 - 2].IsTemple + units[i1 + 1][i2 - 2].IsTemple + units[i1 + 2][i2 - 2].IsTemple + units[i1 - 2][i2 - 1].IsTemple + units[i1 + 2][i2 - 1].IsTemple + units[i1 - 2][i2].IsTemple + units[i1 + 2][i2].IsTemple + units[i1 - 2][i2 + 1].IsTemple + units[i1 + 2][i2 + 1].IsTemple + units[i1 - 2][i2 + 2].IsTemple + units[i1 - 1][i2 + 2].IsTemple + units[i1][i2 + 2].IsTemple + units[i1 + 1][i2 + 2].IsTemple + units[i1 + 2][i2 + 2].IsTemple) >= 1))
			{
				units2[i1][i2].IsLife = units[i1][i2].IsLife;
			}

			//考量水源，当周围二圈有大于等于100水源时，周围个体多于3个的，保持（即撤销它的死亡）。
			if (((units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife) >= 4) &&
				(units[i1 - 1][i2 - 1].IsWater >= 100 || units[i1][i2 - 1].IsWater >= 100 || units[i1 + 1][i2 - 1].IsWater >= 100 || units[i1 - 1][i2].IsWater >= 100 || units[i1 + 1][i2].IsWater >= 100 || units[i1 - 1][i2 + 1].IsWater >= 100 || units[i1][i2 + 1].IsWater >= 100 || units[i1 + 1][i2 + 1].IsWater >= 100 || units[i1][i2].IsWater >= 100 ||
					units[i1 - 2][i2 - 2].IsWater >= 100 || units[i1 - 1][i2 - 2].IsWater >= 100 || units[i1][i2 - 2].IsWater >= 100 || units[i1 + 1][i2 - 2].IsWater >= 100 || units[i1 + 2][i2 - 2].IsWater >= 100 || units[i1 - 2][i2 - 1].IsWater >= 100 || units[i1 + 2][i2 - 1].IsWater >= 100 || units[i1 - 2][i2].IsWater >= 100 || units[i1 + 2][i2].IsWater >= 100 || units[i1 - 2][i2 + 1].IsWater >= 100 || units[i1 + 2][i2 + 1].IsWater >= 100 || units[i1 - 2][i2 + 2].IsWater >= 100 || units[i1 - 1][i2 + 2].IsWater >= 100 || units[i1][i2 + 2].IsWater >= 100 || units[i1 + 1][i2 + 2].IsWater >= 100 || units[i1 + 2][i2 + 2].IsWater >= 100))
			{
				units2[i1][i2].IsLife = units[i1][i2].IsLife;
			}

			//考量神庙，此地有神庙时，没有其他东西。
			if (units[i1][i2].IsTemple == true)
			{
				units2[i1][i2].IsLife = false;
				units2[i1][i2].IsWater = false;
				units2[i1][i2].Water = 0;
			}
			//水源的削减。
			if (units[i1][i2].IsWater == true && units[i1][i2].Water < 100)
			{
				units2[i1][i2].Water -= (units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife);
			}
			else if (units[i1][i2].IsWater == true && units[i1][i2].Water >= 100)
			{
				units2[i1][i2].Water -= (units[i1 - 1][i2 - 1].IsLife + units[i1][i2 - 1].IsLife + units[i1 + 1][i2 - 1].IsLife + units[i1 - 1][i2].IsLife + units[i1 + 1][i2].IsLife + units[i1 - 1][i2 + 1].IsLife + units[i1][i2 + 1].IsLife + units[i1 + 1][i2 + 1].IsLife + units[i1][i2].IsLife +
					units[i1 - 2][i2 - 2].IsLife + units[i1 - 1][i2 - 2].IsLife + units[i1][i2 - 2].IsLife + units[i1 + 1][i2 - 2].IsLife + units[i1 + 2][i2 - 2].IsLife + units[i1 - 2][i2 - 1].IsLife + units[i1 + 2][i2 - 1].IsLife + units[i1 - 2][i2].IsLife + units[i1 + 2][i2].IsLife + units[i1 - 2][i2 + 1].IsLife + units[i1 + 2][i2 + 1].IsLife + units[i1 - 2][i2 + 2].IsLife + units[i1 - 1][i2 + 2].IsLife + units[i1][i2 + 2].IsLife + units[i1 + 1][i2 + 2].IsLife + units[i1 + 2][i2 + 2].IsLife);
			}
			//防止水量数据越界。
			if (units[i1][i2].Water == 0 || units[i1][i2].Water >= 601)
			{
				units2[i1][i2].Water = 0;
				units2[i1][i2].IsWater = false;
			}

			//第三级演化。
			//随机的死亡。
			if ((rand() % 300) == 1)
			{
				units2[i1][i2].IsLife = false;
			}
		}
	}

	for (int i1 = 0; i1 <= width / Iwidth; i1++)			//遍历各单元，将units2的数据投射到units上去。
	{
		for (int i2 = 0; i2 <= height / Iheight - 2; i2++)
		{
			units[i1][i2].IsWater = units2[i1][i2].IsWater;
			units[i1][i2].IsLife = units2[i1][i2].IsLife;
			units[i1][i2].Water = units2[i1][i2].Water;
		}
	}
	water = water + 20;	//提供新水。
	plays--;			//天数减一。

	return;
}

//玩家干涉。
void UpdateWithInput()
{
	DoFire();	//发射清理。
	WaterSet();	//设置水。

	if (plays == 1)	//当这是最后一天时，设置停止符为真。
	{
		stop = true;
	}

	if (Number >= 300 && plays <= 15 && IsMusicTwo == false)
	{
		mciSendString(_T("stop bkmusic"), NULL, 0, NULL);	//关闭音乐。
		mciSendString(_T("close bkmusic"), NULL, 0, NULL);
		mciSendString(L"open .\\c.mp3 alias bkmusic", NULL, 0, NULL);	//播放音乐。
		mciSendString(_T("play bkmusic repeat"), NULL, 0, NULL);
		IsMusicTwo = true;
	}

	//幕间。
	RECT r = { 0,0,width,height };	//定义整幅画面。
	cleardevice();					//清屏并居中显示，停顿。
	settextcolor(WHITE);
	settextstyle(Tsize, 0, _T("宋体"));
	drawtext(_T("一天后……"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
	settextstyle(Tsize*2/3, 0, _T("黑体"));
	outtextxy(0, height - Tsize, _T("现在，你可以按“S”键保存或按任意键继续。"));
	char ss;
	ss=_getch();
	if (ss == 's')
	{
		cleardevice();
		SaveFile();
		//cleardevice();
		drawtext(_T("你依然可以按任意键继续。"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
		_getch();
	}

	return;
}

//开头的对话。
void startingscene()
{
	RECT r = { 0, 0, width, height };	//定义整幅画面。
	TCHAR s[100];						//初始化字符串。

	settextcolor(WHITE);									//输出对话。
	settextstyle(Tsize, 0, _T("宋体"));						//
	drawtext(_T("你好，先生"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);	//

	//实现“按T（tp）跳过”功能。
	settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
	outtextxy(0, height - Tsize, _T("按“T”来跳过剧情。按“D”读档。按任意键以继续。"));
	char temp = _getch();
	if (temp == 't')
	{
		return;
	}
	else if (temp == 'd')
	{
		cleardevice();
		Read_File();
		IsRead = true;
		clearrectangle(0, height - 2 * Iheight, width, height);
		settextcolor(WHITE);															//输出对话。
		settextstyle(Tsize, 0, _T("宋体"));												//
		drawtext(_T("真高兴你回来了。"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);	//
		Sleep(200);
		return;
	}

	cleardevice();	//清屏。

	//以下四行为一组，在屏幕正中输出。
	swprintf_s(s, _T("你的号码是239A95，对吧？"));	//格式化转换字符串。
	dialogue(&r, s);								//输出。
	if (stop == true)								//跳过对话功能。
		return;
	swprintf_s(s, _T("见到你很高兴。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("我是你的新上司，行星事务局驻Andromeda E9-29A特派员。你可以叫我爱丽丝。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("我想你一定知道我们平常吃的肉是从哪来。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("这种方形的生物非常神奇，"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("当身边有4个及以上同类时，它将因缺乏资源而死；"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("而当身边只有1个同类或没有时，它又会因孤独而死。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("当一个空位周围有两个个体时，它们就会在这里产下一个新的同类。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("然而，即使什么情况都没有，它也可能突然死去，原因未知。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("现在您被托付了与维持我们文明息息相关的这项工作：培育这种生物。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("以下的话十分重要，请您看好："));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("这种生物每天都会进行一次上述过程，"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("为了避免打扰它们的正常繁衍，您每天只能对场地进行一次干涉。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("您将得到10个初始个体，"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("您需要把它们放置在场地中，并发挥您的才智，让它们尽可能多地繁衍。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("您将每天得到20单位水，您可以存起来或者在场地中选择几个位置作为水源。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("一个拥有低于一百单位水的水源将能够帮助它周围一圈的个体面对有4个邻居的困境；"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("而一个拥有一百及以上单位水的水源将帮助它周围一圈的个体面对任何困境，"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("同时还能帮助它旁边第二圈的个体面对拥有四个邻居的困境。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("但请注意，水源作用范围内的个体每天都会消耗水源中1单位的水。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("当水源不足以作用支撑范围内的个体来到明天时，它将因争夺而直接干涸，"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("而且您不能收回已经放置的水。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("对了，请注意，个体可以在水源中存活。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("同时，您被授予了一支武器。它能消灭5×5的范围内的一切，包括水源。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("不过，您一共只有三次发射机会，每天至多一次。请谨慎使用。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("最后，我要给您此次任务中最为重要的东西：“神庙”。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("它将无条件支持周围两圈的个体存活，除非它因未知原因突然死亡。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("我代表行星事务局警告您，不要试图探究“神庙”的作用，"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("把它放置在场地上的适当位置就可以了。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("最后，我衷心祝愿您工作顺利。我将在30天后回来检查您的工作成果。再见。"));
	dialogue(&r, s);

	return;
}

//输出过场对话。
void dialogue(RECT * r, TCHAR *s)
{
	settextcolor(WHITE);									//输出对话。
	settextstyle(Tsize, 0, _T("宋体"));						//
	drawtext(s, r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);	//

	//实现“按T（tp）跳过”功能。
	settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
	outtextxy(0, height - Tsize, _T("按“T”来跳过剧情。按任意键以继续。"));
	char temp = _getch();
	if (temp == 't')
	{
		stop = true;
	}

	cleardevice();	//清屏。

	return;
}

//设置水源。
void WaterSet()
{
	clearrectangle(0, height - 2 * Iheight, width, height);			//清空对话栏和提示/数据栏。
	RECT r = { 0,height - 2 * Iheight,width,height - Iheight };		//是文字对话栏。
	RECT r2 = { 0,height - Iheight,width,height };					//提示/数据栏。

	//文字对话栏文字。
	settextcolor(WHITE);
	settextstyle(Tsize, 0, _T("宋体"));
	drawtext(_T("请选择水源的位置"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);

	//提示/数据栏文字。
	settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
	outtextxy(0, height - Tsize, _T("鼠标左键单击某处以建立水源。"));	//提示。
	TCHAR s[100];
	settextstyle(Tsize, 0, _T("宋体"));
	swprintf_s(s, _T("现有水量：%hu	现有个体数：%hu	剩余清理次数：%hu	剩余天数：%hu"), water, Number, fire, plays);
	drawtext(s, &r2, DT_CENTER | DT_VCENTER | DT_SINGLELINE | DT_EXPANDTABS);

	while (1)
	{
		mmsg = GetMouseMsg();				//获得鼠标消息。

		if (mmsg.uMsg == WM_LBUTTONDOWN)	//当左键按下时。
		{
			int x = mmsg.x;					//鼠标位置。
			int y = mmsg.y;
			x = x / Iwidth + 1;				//格子标号。
			y = y / Iheight + 1;
			if (x <= width / Iwidth && y <= height / Iheight - 2 && units[x][y].IsTemple == false)	//不超出范围。
			{
				
				setfillcolor(ColorOfWater);												//水源色。
				fillrectangle(Iwidth*(x - 1), Iheight*(y - 1), Iwidth*(x), Iheight*y);	//显示水源。

				//下方提示。
				settextstyle(Tsize, 0, _T("宋体"));
				clearrectangle(0, height - 2 * Iheight, width, height);					//清空对话栏和提示/数据栏。
				drawtext(_T("请选定位置并输入注水量"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
				settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
				swprintf_s(s, _T("当前剩余水量：%d"), water);
				outtextxy(0, height - Tsize, s);	//提示。

				//读入加水量。
				unsigned short WaterAdd;
				BoardInput(&WaterAdd, x, y);

				//加水。
				if (WaterAdd > water && WaterAdd != 0)	//当数据过大。
				{
					clearrectangle(0, height - Iheight, width, height);			//清空提示/数据栏。
					outtextxy(0, height - Tsize, _T("醒醒，你没有这么多水。"));	//提示。
					if (units[x][y].IsLife == true)
					{
						setfillcolor(ColorOfLife);								//设置格子填充颜色。是个体色。
					}
					else if (units[x][y].IsWater == true)
					{
						setfillcolor(ColorOfWater);								//设置格子填充颜色。是水色。
					}
					else
					{
						setfillcolor(BKColor);									//设置格子填充颜色。是水色。
					}
					fillrectangle(Iwidth*(x - 1), Iheight*(y - 1), Iwidth*(x), Iheight*y);	//画干格子。
					setfillcolor(ColorOfWater);									//设置回水色。

					if (WaterAdd == 666)										//作弊码。
					{
						TCHAR s[50];
						plays = 5;	//作弊。
						InputBox(s, 10, _T("管理员，您的剩余天数已改为5。"), _T("！"), _T("0"), 0, 0, true);	//提示。
						cheater = true;
					}
					else if (WaterAdd == 777)										//作弊码。
					{
						LifeSet();	//作弊。
						cheater = true;
						outtextxy(0, height - Tsize, _T("醒醒，你没有这么多水。"));	//提示。
					}
					else if (WaterAdd == 888)
					{
						TCHAR s[50];
						fire = 400;	//作弊。
						InputBox(s, 10, _T("管理员，您的剩余发射数已改为400"), _T("！"), _T("0"), 0, 0, true);	//提示。
						cheater = true;
					}
					else if (WaterAdd == 999)
					{
						TCHAR s[50];
						water += 100;	//作弊。
						InputBox(s, 10, _T("管理员，您的水量已增加100！"), _T("！"), _T("0"), 0, 0, true);	//提示。
						cheater = true;
					}

					continue;
				}
				else if (WaterAdd == 0)	//当数据为零。
				{
					if (units[x][y].IsLife == true)	//当为个体。否则就为空（神庙不能点）。
					{
						setfillcolor(ColorOfLife);										//设置个体色。
						solidrectangle(Iwidth*(x - 1), Iheight*(y - 1), Iwidth*(x), Iheight*y);	//画个体。
					}
					else
					{
						setfillcolor(BKColor);										//设置格子填充颜色。是背景色。
						fillrectangle(Iwidth*(x - 1), Iheight*(y - 1), Iwidth*(x), Iheight*y);	//画空格子。
					}

					//setfillcolor(ColorOfWater);									//设置回水色。
					units[x][y].IsWater = false;								//这里没水源。
					units2[x][y].IsWater = false;
					return;
				}
				else	//当数据合法。
				{
					water = water - WaterAdd;			//消耗水。
					units[x][y].IsWater = true;			//这里有水源。
					units2[x][y].IsWater = true;		//这里有水源。
					units[x][y].Water += WaterAdd;		//这里有水源。
					units2[x][y].Water += WaterAdd;		//这里有水源。
					if (water == 0)						//若玩家剩余水量为0，则直接停止过程。
					{
						return;
					}

					clearrectangle(0, height - Iheight, width, height);	//清空提示/数据栏。
					swprintf_s(s, _T("当前剩余水量：%d"), water);
					outtextxy(0, height - Tsize, s);	//提示。
				}
			}

		}
	}
	clearrectangle(0, height - 2 * Iheight, width, height);	//清空对话栏和提示/数据栏。

	return;
}

//设置初始生命单位。
void LifeSet()
{
	clearrectangle(0, height - 2 * Iheight, width, height);			//清空对话栏和提示/数据栏。
	RECT r = { 0,height - 2 * Iheight,width,height - Iheight };		//是文字对话栏。

	//下方提示栏。
	settextcolor(WHITE);
	settextstyle(Tsize, 0, _T("宋体"));
	drawtext(_T("请选择初始个体的位置"), &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
	settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
	outtextxy(0, height - Tsize, _T("鼠标左键单击某处以放下个体。"));

	for (int count = 10; count > 0;)
	{
		//下方提示栏。
		clearrectangle(0, height - Iheight, width, height);	//清空提示/数据栏。
		settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
		TCHAR s[100];
		swprintf_s(s, _T("鼠标左键单击某处以放下个体。您还有%d个个体"), count);
		outtextxy(0, height - Tsize, s);

		mmsg = GetMouseMsg();	//获取鼠标消息。

		if (mmsg.uMsg == WM_LBUTTONDOWN)
		{
			int x = mmsg.x;		//鼠标位置。
			int y = mmsg.y;
			x = x / Iwidth + 1;	//格子标号。
			y = y / Iheight + 1;

			if (x <= width / Iwidth && y <= height / Iheight - 2 && units[x][y].IsLife == false && units[x][y].IsTemple == false)	//不超出范围。
			{
				units[x][y].IsLife = true;												//这里有生命。
				units2[x][y].IsLife = true;												//这里有生命。
				setfillcolor(ColorOfLife);												//设置为生命色。

				if (units[x][y].IsWater == true)	//若要在水中藏个小可爱。
				{
					fillrectangle(Iwidth*(x - 1) + Iwidth / 4, Iheight*(y - 1) + Iheight / 4, Iwidth*(x)-Iwidth / 4, Iheight*y - Iheight / 4);	//显示个体。
				}
				else
				{
					fillrectangle(Iwidth*(x - 1), Iheight*(y - 1), Iwidth*(x), Iheight*y);	//显示个体。
				}
				settextstyle(Tsize, 0, _T("宋体"));
				clearrectangle(0, height - 2 * Iheight, width, height);					//清空对话栏和提示/数据栏。

				count--;	//剩余个体减一。
			}
		}
	}
	clearrectangle(0, height - 2 * Iheight, width, height);	//清空对话栏和提示/数据栏。

	return;
}

//结尾处的对话。
void cutscene()
{
	//初始化所需数组、整幅画面、stop。
	TCHAR s[100];
	RECT r = { 0,0,width ,height };
	stop = false;

	if (Number == 0)	//如果玩家手误全清了。
	{
		//获取窗口句柄并更改窗口名称。
		HWND hwnd = GetHWnd();
		SetWindowText(hwnd, _T("哦，天哪。"));

		//对话。
		swprintf_s(s, _T("哦不，看你干了什么！"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("你想要以这种方式反抗吗？"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("很好，我们曾给你一次机会，但现在，不会有第二次了！"));
		dialogue(&r, s);

		return;
	}

	//读取纪录。
	int elder_Number = 0;						//以前的最高纪录。
	FILE *fp;								//定义FILE指针。
	fopen_s(&fp, ".\\record.txt", "r");		//打开文件,读。
	fscanf_s(fp, "%d", &elder_Number);		//读取纪录。
	fclose(fp);								//关闭文件。
	if (elder_Number <= Number)				//如果是新纪录。
	{
		fopen_s(&fp, ".\\record.txt", "w");	//打开文件，写。
		fprintf_s(fp, "%d", Number);		//记录。
		fclose(fp);							//关闭文件
	}

	//对话。
	swprintf_s(s, _T("你好，先生。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("我们又见面了！三十天过得真快，不是吗？"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("下面，我将对你这段时间的工作成果进行评估。"));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("你现在拥有的个体数是：%d"), Number);
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("你剩余的水有：%d"), water);
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("你进行清理的次数为：%d"), (3 - fire));
	dialogue(&r, s);
	if (stop == true)
		return;
	swprintf_s(s, _T("迄今为止做得最好的以为创造了%d个个体的记录。"), elder_Number);
	dialogue(&r, s);
	if (stop == true)
		return;
	if (elder_Number < Number && Number >= downer)	//为新纪录且不是太低。（主要是为了避免第一次游戏时发生这种状况）。
	{
		swprintf_s(s, _T("干得不错。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}

	//评价。
	if (Number >= upper && water >= upper1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于22世纪大型养鸡场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("利用最少的资源，并且不惜使用极端手段，以求最大化收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("如果不从动物的立场来看，你是个伟大的养殖者，先生。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number >= upper && water >= upper1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于21世纪以色列的畜牧业"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("利用最少的资源，同时兼顾动物的感受，最终获得最大化收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("干得好，先生。你是个伟大的养殖者，更是伟大的人道主义者。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number >= upper && upper1 > water&&water >= downer1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于20世纪中国的人民公社运动。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("利用了正常数目的资源，并且使用非常化的政策与方式，短期内大幅提升了产品数量。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("你做的不错。但我也要提醒你，但纯追求数量容易导致产品质量的下滑。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number >= upper && upper1 > water&&water >= downer1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于21世纪美国的牧场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("利用正常数量的资源，避免使用极端手段，获得持久稳定的较大收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("干得好，先生。不过，你可以再思考一下，我们使用的资源能否再少些？"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number >= upper && water < downer1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于小罗斯福时期的美国。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("你过度利用乃至浪费了大量资源，这与当时牛奶倒入密西西比河有异曲同工之妙。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("同时，你还使用了极端调控手段，类似于当时美国农民屠宰牲畜后埋掉。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("不过，好在你成功地保证了产品数量。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("我可以告诉你，你现在不会被开除了，先生。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("不过，要想持久地拥有这份工作，你还得继续学习才行。祝你好运。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number >= upper && water < downer1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于21世纪中国的内蒙古地区"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("利用过量的资源，追求最大数量的牲畜数？"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("短时间来看，你做的不错。不过，你考虑过资源消耗殆尽后，明年我们该怎么办吗？"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("希望这个星球不会变成一片沙漠戈壁……"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (upper > Number&&Number >= downer && water >= upper1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于上古中国的少数民族牧民。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("利用极少资源，利用特殊智慧应对各种各样的天灾，仍能获得足够的收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("干得不错，先生。你的经验将会成为“逆境牧业”教材的宝贵实例。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (upper > Number&&Number >= downer && water >= upper1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于西欧式牧场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("凭借得天独厚的地缘优势，你只利用了很少的资源。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("并且避免使用极端、不人道的手段，获得足够的收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("做的不错。当然，如果产品数量再多些，就更完美了。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (upper > Number&&Number >= downer && upper1 > water&&water >= downer1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于口蹄疫爆发下的牧场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("面对疫情，你使用了极端的手段消灭部分个体，以保证基本的收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("我佩服你面对逆境时的果断与决绝。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (upper > Number&&Number >= downer && upper1 > water&&water >= downer1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于阿根廷式牧场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("中规中矩的资源，中规中矩的养殖方式，中规中矩的产品数量……"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("嗯……我可以考虑给你一个正态分布后的分数！"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (upper > Number&&Number >= downer && water < downer1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于20世纪苏联采用的战时共产主义。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("在特殊的历史背景下，你消耗大量资源，并且不惜使用极端手段控制产品数量。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("只为了获得最终的胜利……"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("我必须提醒你，类似的极端养殖法以后还是少用为妙！"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (upper > Number&&Number >= downer && water < downer1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于苏联的牧场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("可以看出，大水漫灌是你的基本操作。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("不过，看看实际的产品数量，你可能需要好好反思一下。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number < downer && water >= upper1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于受连绵战火之苦的地区。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("资源？你几乎没怎么使用。产品？你也没收获多少。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("并且还时不时有炮火杀伤你的动物……"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("不过，我们的星球可没在打仗。下次检查我不希望再看到这种情况！"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number < downer && water >= upper1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于中国古代的小农经济。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("资源？你几乎没怎么使用。产品？你也没收获多少。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("一切都很平和，让我感觉你已与世无争……"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("不过，现在你担任的是现代牧场的管理人。你的管理思想急需更新换代！"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number <downer && upper1> water&&water >= downer1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于澳大利亚的早期牧场。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("在有限的资源面前，你使用了类似黏液瘤病毒的方式，保证了最最基本的少量收益。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("有效，但仍有极大的提升空间。你还要多多学习啊！"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number <= downer && upper1 > water&&water >= downer1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于欧洲古代的牧业。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("你没收获多少产品。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("不过，你与中国小农经济的差距在于，你不懂得天人合一的思想，因而消耗了更多资源。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("我发誓，下次我再看到你使用这种落后的生产方式，就马上把你开除！"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("我想你懂得，“开除”是什么意思吧，huh？"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number < downer && water < downer1 && 3 - fire != 0) {
		swprintf_s(s, _T("你的养殖策略类似于苏联农业集体化运动。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("资源？反正有的是，用！极端手段、高压政策？无所谓，用！"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("可是你在做了这么多好事以后，我们再看看你可怜的收益……"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("你或许应该换一份别的工作做。再见。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}
	if (Number < downer && water < downer1 && 3 - fire == 0) {
		swprintf_s(s, _T("你的养殖策略类似于撒哈拉沙漠地区的牧业。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("资源已经没有了榨取的空间。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("动物的数量也像沙漠中的生物数量一样可怜。"));
		dialogue(&r, s);
		if (stop == true)
			return;
		swprintf_s(s, _T("在赶你走之前，我要祝贺你发现了一种让一片沃土快速沙漠化的方法。"));
		dialogue(&r, s);
		if (stop == true)
			return;
	}

	return;
}

//游戏结束。
void gameover()
{
	mciSendString(_T("stop bkmusic"), NULL, 0, NULL);	//停止音乐。
	mciSendString(_T("close bkmusic"), NULL, 0, NULL);	//关闭音乐。

	movie();					//乱码及读条动画。
	setbkcolor(BKColor);		//清屏。
	setbkmode(TRANSPARENT);
	cleardevice();
	cutscene();					//结尾对话。

	setbkcolor(BLACK);			//清屏。
	setbkmode(TRANSPARENT);
	cleardevice();

	Sleep(24 * 60 * 60 * 100);	//要想永远不退出，暂停一整天就行了。

	return;
}

//发射。
void Fire(int x, int y)
{
	//轰！清空5×5范围内的水和个体。
	for (int i1 = x - 2; i1 <= x + 2; i1++)
	{
		for (int i2 = y - 2; i2 <= y + 2; i2++)
		{
			units[i1][i2].IsWater = false;
			units[i1][i2].IsLife = false;
			units[i1][i2].Water = 0;

			units2[i1][i2].IsWater = false;
			units2[i1][i2].IsLife = false;
			units2[i1][i2].Water = 0;
		}
	}

	fire--;	//子弹数减一。

	//发射动画。
	setfillcolor(ColorOfFire);
	solidrectangle(Iwidth*(x - 3), Iheight*(y - 3), Iwidth*(x + 2), Iheight*(y + 2));	//画火方块。
	Sleep(500);	//停顿。
	setfillcolor(BKColor);
	solidrectangle(Iwidth*(x - 3), Iheight*(y - 3), Iwidth*(x + 2), Iheight*(y + 2));	//画背景方块。

	return;
}

//进行清理。
void DoFire()
{
	if (fire >= 0)	//当你确实还有发射机会。
	{
		TCHAR s[50];
		RECT r1 = { 0,height - 2 * Iheight,width,height - Iheight };		//对话栏。
		RECT r2 = { 0,height - Iheight,width,height };						//提示/数据栏。

		settextstyle(Tsize, 0, _T("宋体"));
		clearrectangle(0, height - 2 * Iheight, width, height);					//清空对话栏和提示/数据栏。
		//下边栏提示。
		drawtext(_T("请选择是否发动清理，发动则选择目标地点，否则点击下方文字栏。"), &r1, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
		settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
		swprintf_s(s, _T("当前剩余清理机会：%d"), fire);
		outtextxy(0, height - Tsize, s);
		settextstyle(Tsize, 0, _T("宋体"));
		swprintf_s(s, _T("现有水量：%hu	现有个体数：%hu	剩余清理次数：%hu	剩余天数：%hu"), water, Number, fire, plays);
		drawtext(s, &r2, DT_CENTER | DT_VCENTER | DT_SINGLELINE | DT_EXPANDTABS);

		int x1 = -4, y1 = -4;	//初始化格子标号变量。
		bool yes = false;		//用于表示“确定？”的变量。

		while (1)
		{
			mmsg = GetMouseMsg();	//获取鼠标消息。

			if (mmsg.uMsg == WM_LBUTTONDOWN && yes == false)	//当第一次点击某格子时。
			{
				int x = mmsg.x;			//鼠标位置。
				int y = mmsg.y;
				x1 = x / Iwidth + 1;	//格子标号。
				y1 = y / Iheight + 1;
				if (x1 <= width / Iwidth && y1 <= height / Iheight - 2 && units[x1][y1].IsTemple == false)	//不超出范围。
				{
					//下边栏提示。
					settextstyle(Tsize, 0, _T("宋体"));
					clearrectangle(0, height - 2 * Iheight, width, height);					//清空对话栏和提示/数据栏。
					drawtext(_T("你确定吗？确定请再次点击目标地点。"), &r1, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
					settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
					swprintf_s(s, _T("当前剩余清理机会：%d"), fire);
					outtextxy(0, height - Tsize, s);	//提示。

					yes = true;	//表示“确定吗？”。
				}
				else if (x1 <= width / Iwidth && y1 > height / Iheight - 2)	//如果点击的是下边栏，那么就终止过程。
				{
					break;
				}
			}
			else if (mmsg.uMsg == WM_LBUTTONDOWN && yes == true)	//当第二次点击某格子时。
			{
				int x = mmsg.x;	//鼠标位置。
				int y = mmsg.y;

				if (x1 == x / Iwidth + 1 && y1 == y / Iheight + 1)	//确实是这格。
				{
					Fire(x1, y1);	//轰！清理。

					//下边栏提示。
					settextstyle(Tsize, 0, _T("宋体"));
					clearrectangle(0, height - 2 * Iheight, width, height);					//清空对话栏和提示/数据栏。
					drawtext(_T("已清理！"), &r1, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
					settextstyle(Tsize * 2 / 3, 0, _T("黑体"));
					swprintf_s(s, _T("当前剩余清理机会：%d"), fire);
					outtextxy(0, height - Tsize, s);	//提示。

					Screen();	//显示。

					return;
				}
				else	//确实不是这格。
				{
					break;
				}
			}
		}

		Screen();	//显示。
	}
	return;
}

//输入框。
void BoardInput(unsigned short *WaterAdd, int x, int y)
{
	TCHAR input[30];						// 定义字符串缓冲区。
	char s[30];
	TCHAR s1[50];

	swprintf_s(s1, _T("输入所要加之水量,输入0以停止过程。此格水量：%hu"), units[x][y].Water);	//格式化字符串之转换。
	InputBox(input, 10, s1, _T("C45型管理器"), _T("0"), 0, 0, true);	//建立输入窗口，接受输入。
	TcharToChar(input, s);			//将输出的TCHAR型字符串转换为char型字符串。
	sscanf_s(s, "%hu", WaterAdd);	// 将用户输入（即经转换得到的char型字符串）转换为数字。

	return;
}

//将TCHAR型的字符串转换为char型的字符串。
void TcharToChar(const TCHAR * tchar, char * _char)
{
	//将TCHAR转为char。
	//*tchar是TCHAR类型指针，*_char是char类型指针。
	//（完全看不懂（ToT））
	int iLength;	//获取字节长度。
	iLength = WideCharToMultiByte(CP_ACP, 0, tchar, -1, NULL, 0, NULL, NULL);	//将tchar值赋给_char。
	WideCharToMultiByte(CP_ACP, 0, tchar, -1, _char, iLength, NULL, NULL);

	return;
}

//乱码及进度条小动画。
void movie()
{
	srand(time(NULL));	//设置种子。

	//以背景色清屏。
	setbkcolor(BKColor);
	setbkmode(TRANSPARENT);
	cleardevice();

	for (int i = 0; i <= 24; i++)
	{
		//定义和初始化所需变量。
		int x1, x2, x3, x4, trans;
		x1 = rand() % width;
		x2 = rand() % height;
		x3 = rand() % width;
		x4 = rand() % height;

		//调整顺序。
		if (x1 > x3)
		{
			trans = x1;
			x1 = x2;
			x2 = trans;
		}
		if (x2 > x4)
		{
			trans = x2;
			x2 = x4;
			x4 = trans;
		}

		//画混乱的方块们。
		setfillcolor(BLACK);
		solidrectangle(x1, x2, x3, x4);
		Sleep(42);
		setfillcolor(BKColor);
		solidrectangle(x1, x2, x3, x4);
	}

	//用黑色清屏。
	setbkcolor(BLACK);
	setbkmode(TRANSPARENT);
	cleardevice();

	//屏幕正中输出。
	TCHAR s[50];
	RECT r = { 0,0,width,height };
	swprintf_s(s, _T("建立连接中……"));
	settextcolor(WHITE);
	settextstyle(Tsize, 0, _T("宋体"));
	drawtext(s, &r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);

	//假进度条。
	stop = false;
	int x1 = 0.191*width;
	int y1 = 0.618*height;
	int x2 = 0.809*width;
	int y2 = y1 + 20;
	int x3 = x1 + rand() % 20;
	while (x3 <= x2 - 0.2*width)
	{
		setfillcolor(RGB(48, 199, 251));
		solidrectangle(x1, y1, x3, y2);
		x3 = x3 + rand() % 10;
		Sleep(10);
	}
	solidrectangle(x1, y1, x2, y2);
	Sleep(500);

	return;
}

//读档。
void Read_File()
{
	FILE *file;
	fopen_s(&file, ".\\file.txt", "r");
	for (int x = 0; x <= width / Iwidth; x++)
	{
		for (int y = 0; y <= height / Iheight - 2; y++)
		{
			fscanf_s(file, "%d %d %d %hu %d %d %d %hu\n", &units[x][y].IsWater, &units[x][y].IsLife, &units[x][y].IsTemple, &units[x][y].Water, &units2[x][y].IsWater, &units2[x][y].IsLife, &units2[x][y].IsTemple, &units2[x][y].Water);
		}
	}
	outtextxy(0, 0, _T("reading finished!"));
	fscanf_s(file, "%d %d %d %d", &water, &fire, &cheater, &plays);
	fclose(file);
	return;
}

//存档。
void SaveFile()
{
	FILE *file;
	fopen_s(&file, ".\\file.txt", "w");
	for (int x = 0; x <= width / Iwidth; x++)
	{
		for (int y = 0; y <= height / Iheight - 2; y++)
		{
			fprintf_s(file, "%d %d %d %hu %d %d %d %hu\n", units[x][y].IsWater, units[x][y].IsLife, units[x][y].IsTemple, units[x][y].Water, units2[x][y].IsWater, units2[x][y].IsLife, units2[x][y].IsTemple, units2[x][y].Water);
		}
	}
	fprintf_s(file, "%d %d %d %d", water, fire, cheater, plays);
	outtextxy(0, 0, _T("writing finished!"));
	fclose(file);
	return;
}