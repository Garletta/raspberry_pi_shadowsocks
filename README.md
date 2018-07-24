# raspberry_pi_shadowsocks
raspberry pi 3b+ 树莓派 shadowsocks 科学上网

  >Raspberry pi 3 Model B+  
  >OS：原装系统  
  >版本：Element 14  
  
## 本文为使用 python 版本的 shadowsocks 客户端来实现科学上网  

安装 python 版本的 shadowsocks 客户端与相关套件  

    sudo apt-get install python-pip python-m2crypto  
    sudo apt-get install shadowsocks  
    
修改配置文件:  

    cd /etc/shadowsocks  
    sudo vim config.json  
    
修改为如下内容：  

    {
        "server":"xxx.xxx.xxx.xxx",
        "server_port":xxxx,
        "local_address":"127.0.0.1",
        "local_port":1080,
        "password":"xxxxxxxx",
        "timeout":600,
        "method":"aes-256-cfb",
        "fast_open":false
    }

  >server ：服务端IP  
  >server_port ：服务端开放的端口，注意没有双引号  
  >password ：端口对应的密码  
  >method ：根据自己设定的服务端的加密方式来改  
  
启动：  

    sudo /usr/bin/sslocal -c /etc/shadowsocks/config.json -d start  

若报错：  

    Traceback (most recent call last):  
    File "/usr/local/bin/sslocal", line 9, in   
    load_entry_point('shadowsocks==2.8.2', 'console_scripts', 'sslocal')()  
    ....  
    ....  
    ....  
    AttributeError: /usr/local/lib/libcrypto.so.1.1: undefined symbol: EVP_CIPHER_CTX_cleanup  
    
则是由于Openssl库更新导致的方法名称变更问题，修复方法如下：  

    sudo vim /usr/local/lib/python2.7/distpackages/shadowsocks/crypto/openssl.py  

修改两条语句：  

    libcrypto.EVP_CIPHER_CTX_cleanup.argtypes = (c_void_p,)  
    #改为  
    ibcrypto.EVP_CIPHER_CTX_reset.argtypes = (c_void_p,)
>
    libcrypto.EVP_CIPHER_CTX_cleanup.argtypes = (self._ctx)  
    #改为  
    libcrypto.EVP_CIPHER_CTX_reset.argtypes = (self._ctx)  

重启，再次执行启动命令即可  

添加开机启动：  

    sudo echo "/usr/bin/local -c /etc/shadowsocks/config.json -d start" >> /etc/rc.local  

至此，ss 客户端已经配置完毕！！！

## 配置 chromium/firefox SwitchOmega 

下载链接：[SwitchOmega](https://github.com/FelisCatus/SwitchyOmega/releases)  

把下载好的直接拉进扩展程序  

  >代理协议：SOCKS5  
  >代理服务器：127.0.0.1  
  >代理端口：1080  

![image](https://github.com/Garletta/raspberry_pi_shadowsocks/tree/master/images/raspberry_youtube.jpg)  
