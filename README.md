## 山理工宿舍管理系统

### 亮点

#### 前端

bootstrap用的比较多，容易造成视觉疲劳，本项目基于layui进行开发，layui是由职业前端倾情打造，面向所有层次的前后端开发者，零门槛开箱即用的前端UI解决方案 。此外此UI还集成了JQuery。点此访问[官网](https://www.layui.com/)。

**学生端首页**

+ 导航栏高度自适应：js监听窗口改变事件，通过计算子元素宽度和与浏览器窗口宽度比较，当子元素宽度和大于浏览器窗口大小时，导航栏高度变为原来的一倍。
+ 点赞功能：通过ajax技术实现点赞数+1，js监听点击按钮事件，点赞后改变样式，再次点击无效。