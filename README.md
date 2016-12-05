#JMFunHUD
A creative and fun HUD can be easily added to your project ^ ^


![Dim](https://github.com/jiemi/JMFunHUD/blob/master/GIF/dimgif.gif?raw=true)

![Blur](https://github.com/jiemi/JMFunHUD/blob/master/GIF/blurGif.gif?raw=true)

##Usage
At first, import JMFunHUD.h

```
import "JMFunHUD.h"

```
###Normal Usage
Show HUD

```
JMFunHUD *hud = [JMFunHUD hudForView:self.view];
hud.backgroundType = JMFunHUDBackgroundTypeBlur;
[hud show:YES];

```

Hide HUD 

```
[hud hide:true];

```

###Shared HUD
Or you can show a shared hud and note that the shared HUD is added to window by default .

```
[JMFunHUD showSharedHUD:YES withType:JMFunHUDBackgroundTypeBlur];
```

Note that you should hide it as shown below.

```
[JMFunHUD hideSharedHUD:YES];

```