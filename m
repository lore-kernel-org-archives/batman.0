Message-ID: <45B60365.7010502@gmx.net>
Date: Tue, 23 Jan 2007 13:45:25 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] meshliunx
References: <37176.81.188.21.235.1169462818.squirrel@lecurie.homelinux.org>	<200701231029.22069.lindner_marek@yahoo.de>
	<45B5EEB3.5040203@bb.banban.jp>
In-Reply-To: <45B5EEB3.5040203@bb.banban.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello Kazuki -
> I am so interested in meshlinux. Can I make any question?
> - Is meshlinux built on something well-known distribution, like 
> freifunk on openwrt?
Meshlinux is targeted at the re-use of PC hardware for wireless routers. 
Currently it is based on Slackware.  At the moment Meshlinux is nothing 
fancy. The philosophy behind Meshlinux is KISS, stability and 
flexibility. No webinterface, no fancy package management - yet. But 
b.a.t.m.a.n., bridge-utils, quagga (RIP, BGP, OSPF v2 and v3...) 
up-to-date OLSRD with fisheye & ETX, apache, nmap, ncftp, proftp, rsync, 
horst, ff-trace, serial terminal, openvpn etc. It installs from a 
bootable CD to a harddrive within approximately 2 minutes on a Pentium 
III. I'll make an image for CF-Cards also - so you could use it with a 
WRAP-Board or Soekris. There will be 3 versions - one with complete 
compiling/building environment (including kernel-sources) for HD-install 
or a chroot environment on your Desktop so you can compile/build 
anything that you think is missing (like the newest SVN-checkout of a 
driver or a special patch), and two stripped-down ones - one for HD 
install and the CF-Image.

The recommended wifi-cards of today for Linux are using the Atheros 
chipset. If you really want to have bandwidth you need a powerful CPU 
for these cards. A 200 MHz Mips-CPU will give you a maximum throughput 
of 1.28 MByte/sec over a direct link (tested with Netgear WGT634U). The 
same cards can do ~ 3 MByte/sec without turbo-mode on a faster host CPU.

If you want bandwidth and more than one interface you will be much 
better off with a router based on a PC and PCI-cards. Of course it will 
be quite bulky and consume more power than a little embedded device. 
Meshlinux may be a good choice for a core-router or server (http, ftp, 
sip, icecast ... you name it) for local content. Administrators of such 
routers may not miss a webinterface.

cu elektra









>
> - Does it depend on specific architecture and/or board, 
> mips-arm-broadcom-la-la-la?
> - Does it have a package manegement system,  like ipkg?
> - it seems b.a.t.m.a.n. takes account of multi wireless 
> module/interface, does meshlinux support multi radio?
> http://www.google.co.jp/search?hl=ja&q=multi+radio&btnG=Google+%E6%A4%9C%E7%B4%A2&lr= 
>
>
> Anyway, I'm so ready to see her(him?) ; )
>
> Best regards,
>
> Kazuki
>> from Nagasaki Japan
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

