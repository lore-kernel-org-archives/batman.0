Return-Path: <zukky@bb.banban.jp>
Message-ID: <4C760EEB.4000001@bb.banban.jp>
Date: Thu, 26 Aug 2010 15:51:23 +0900
From: Kazuki Shimada <zukky@bb.banban.jp>
MIME-Version: 1.0
References: <4C6437BF.9080909@web.de>	<201008201824.22693.lindner_marek@yahoo.de>	<4C6F5DC7.5010303@bb.banban.jp>
	<201008210801.17503.lindner_marek@yahoo.de>
In-Reply-To: <201008210801.17503.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
 in my case
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

  Hi, Marek and Sven.

I'm sorry to be late to reply.
Thank you for your instruction and patches.
I could update to latest revision 1778 and built successfully.

I met a new problem.
After configuration, I entered /etc/init.d/network restart

root@OpenWrt:/# /etc/init.d/network restart
br-lan: port 3(bat0) entering disabled state
br-lan: port 1(eth0) entering disabled state
device bat0 left promiscuous mode
br-lan: port 3(bat0) entering disabled state
device eth1 left promiscuous mode
br-lan: port 2(eth1) entering disabled state
device eth0 left promiscuous mode
br-lan: port 1(eth0) entering disabled state
eth0: link down
device eth0 entered promiscuous mode
device eth1 entered promiscuous mode
device bat0 entered promiscuous mode
br-lan: port 3(bat0) entering forwarding state
batman_adv: bat0: Interface deactivated: wlan0
batman_adv: bat0: Removing interface: wlan0
eth0: link up, speed 100 Mb/s, full duplex
br-lan: port 1(eth0) entering forwarding state
batman_adv: bat0: Interface deactivated: wlan1
batman_adv: bat0: Removing interface: wlan1

After this line, console stopped. No key input was recieved.


Thanks in advance.

Kazuki Shimada



(2010/08/21 15:01), Marek Lindner wrote:
> On Saturday 21 August 2010 07:01:59 Kazuki Shimada wrote:
>> PKG_REV:=1729
>>
>> [..]
>> ------------------------------------
>>
>> My update procedure is
>> cd openwrt/trunk
>> ./script/feeds update
>>
>> .... Is this wrong? :-s
> No, it is not wrong but you might want to change the PKG_REV field to match
> with the SVN revision you want to use. If you are interested in the latest
> trunk you should set it to 1776.
> We don't update this number each time something gets committed.
>
> Cheers,
> Marek
>
>

