Message-ID: <8c906fa50809111518y799f5a29me41a8ece69f47ae4@mail.gmail.com>
Date: Thu, 11 Sep 2008 19:18:58 -0300
From: "Gustavo Lindberg" <gus.lindberg@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BATGAT
In-Reply-To: <200809111101.31420.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23230_6212474.1221171538935"
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
	<20080910193801.GA10777@pandem0nium>
	<8c906fa50809101400i4c30cff5geb16998e11d7c607@mail.gmail.com>
	<200809111101.31420.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

------=_Part_23230_6212474.1221171538935
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just tried the last openwrt-kamikaze trunk with the svn v1109 of batman on
ubnt NS2. Batmand die as follows:

 root@OpenWrt:~# batmand -d 4 -g 5000 ath2
WARNING: You are using the unstable batman branch. If you are interested in
*using* batman get the latest stable release !
Interface activated: ath2
Using interface ath2 with address 5.0.0.1 and broadcast address
5.255.255.255
B.A.T.M.A.N. 0.3-beta (compatibility version 5)
[        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
address
[        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
address


dmesg output:

Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps
24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2315 WiSoC: mem=0xb0000000, irq=3
gpio-buttons driver version 0.1.1
batgat: [batgat_ioctl:224] name gate0 index 7
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
batgat: [batgat_ioctl:224] name gate0 index 8
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
batgat: [batgat_ioctl:224] name gate0 index 9
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
batgat: [batgat_ioctl:224] name gate0 index 10
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
root@OpenWrt:~#
No iptables rules at all. All policy ACCEPT.

BATGAT dont crash anymore, Keep live.



Greetings.
Gustavo.

2008/9/11 Marek Lindner <lindner_marek@yahoo.de>

> On Thursday, 11. September 2008 05:00:59 Gustavo Lindberg wrote:
> > I am experimenting very frustrating issues with batgat. Currently i am
> > testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly
> > with batgat loaded. I will prove the last kamikaze on two NS2 without
> > batgat and inform the bug  if this error happen again.
>
> I think it would be intersting to find out why batmand dies. May be you
> could
> produce a core dump ?
> Indeed, we have a problem if the batman daemon dies without telling the
> module. What about adding a keep alive + timeout in the module ?
>
> Greetings,
> Marek
>  _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_23230_6212474.1221171538935
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>I just tried the last openwrt-kamikaze trunk with the svn v1109 of batman on ubnt NS2. Batmand die as follows:</div>
<div>&nbsp;</div>
<div>&nbsp;<a href="mailto:root@OpenWrt">root@OpenWrt</a>:~# batmand -d 4 -g 5000 ath2<br>WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !<br>Interface activated: ath2<br>
Using interface ath2 with address <a href="http://5.0.0.1">5.0.0.1</a> and broadcast address <a href="http://5.255.255.255">5.255.255.255</a><br>B.A.T.M.A.N. 0.3-beta (compatibility version 5)<br>[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80] Error - can&#39;t set IFFLAGS for gate0: Cannot assign requested address<br>
[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80] Error - can&#39;t set IFFLAGS for gate0: Cannot assign requested address</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>dmesg output:</div>
<div>&nbsp;</div>
<div>Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies<br>wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps<br>wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps<br>
wifi0: H/W encryption support: WEP AES AES_CCM TKIP<br>ath_ahb: wifi0: Atheros 2315 WiSoC: mem=0xb0000000, irq=3<br>gpio-buttons driver version 0.1.1<br>batgat: [batgat_ioctl:224] name gate0 index 7<br>batgat: [batgat_ioctl:244] disconnect daemon<br>
batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br>batgat: [batgat_ioctl:224] name gate0 index 8<br>
batgat: [batgat_ioctl:244] disconnect daemon<br>batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br>
batgat: [batgat_ioctl:224] name gate0 index 9<br>batgat: [batgat_ioctl:244] disconnect daemon<br>batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>batgat: [batgat_ioctl:263] gate shutdown<br>
batgat: [batgat_ioctl:277] device unregistered successfully<br>batgat: [batgat_ioctl:224] name gate0 index 10<br>batgat: [batgat_ioctl:244] disconnect daemon<br>batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>
batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br><a href="mailto:root@OpenWrt">root@OpenWrt</a>:~#&nbsp;&nbsp; <br></div>
<div>No iptables rules at all. All policy ACCEPT.</div>
<div>&nbsp;</div>
<div>BATGAT dont crash anymore, Keep live.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Greetings.</div>
<div>Gustavo.<br><br></div>
<div class="gmail_quote">2008/9/11 Marek Lindner <span dir="ltr">&lt;<a href="mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</span><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class="Ih2E3d">On Thursday, 11. September 2008 05:00:59 Gustavo Lindberg wrote:<br>&gt; I am experimenting very frustrating issues with batgat. Currently i am<br>&gt; testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly<br>
&gt; with batgat loaded. I will prove the last kamikaze on two NS2 without<br>&gt; batgat and inform the bug &nbsp;if this error happen again.<br><br></div>I think it would be intersting to find out why batmand dies. May be you could<br>
produce a core dump ?<br>Indeed, we have a problem if the batman daemon dies without telling the<br>module. What about adding a keep alive + timeout in the module ?<br><br>Greetings,<br><font color="#888888">Marek<br></font>
<div>
<div></div>
<div class="Wj3C7c">_______________________________________________<br>B.A.T.M.A.N mailing list<br><a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br><a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br></div>

------=_Part_23230_6212474.1221171538935--
