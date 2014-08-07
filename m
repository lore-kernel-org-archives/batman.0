Return-Path: <ff@jluehr.de>
Message-ID: <53E33BE5.30007@jluehr.de>
Date: Thu, 07 Aug 2014 10:42:13 +0200
From: =?ISO-8859-1?Q?Jan_L=FChr?= <ff@jluehr.de>
MIME-Version: 1.0
References: <53E274D5.1070008@jluehr.de>
 <201408071037.36351.sw@simonwunderlich.de>
In-Reply-To: <201408071037.36351.sw@simonwunderlich.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] alfred: IPC issues
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

thanks for your feedback.

Am 08/07/2014 10:37 AM, schrieb Simon Wunderlich:
> Hello Jan,
> 
>> Hei folks,
>>
>> I'm using alfred 2014.0.0 on OpenWRT Barrier Breaker.
>>
>> Alfred is running:
>> root@6466b34ffcac:~# ps -w | grep alfred
>>  1718 root      1100 S    /usr/sbin/alfred -i br-freifunk -b bat0
>>
>> But cannot be queried using the client:
>> root@6466b34ffcac:~# alfred -r 94
>> can't connect to unix socket: Connection refused
>>
>> What's wrong here?
>>
(...)


> I don't see a problem right from your configuration. Can you please check:
> 
>  * do you see the socket file /var/run/alfred.sock after starting alfred? 

Looks nice..
root@6466b34ffcac:~# ls -lh /var/run/alfred.sock
srwxr-xr-x    1 root     root           0 Aug  6 20:47 /var/run/alfred.sock

>  * does the same problem happen if you restart alfred or start it manually?
/etc/init.d/alfred restart made it disappear

For some reason, this is persistent:
* Before restarting, alfred was unusable after rebooting the machine
* After a restarting once, alfred is usable - even after reboots

Greetu, Jan
