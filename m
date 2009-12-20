Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Sun, 20 Dec 2009 16:01:05 +0100
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22C241@RESQNAOEX01.qnao.net>
	<2ced936d0912191025k5fbdbf45s2c1b16d241850549@mail.gmail.com>
	<20091219191559.GA2932@Linus-Debian>
In-Reply-To: <20091219191559.GA2932@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200912201601.05350.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] wireless adapter and linux kernel version
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hello all -

I have been into testing and finding wireless drivers that do the trick in 
ad-hoc mode for quite a while. Linux has made great progress with this 
regard. Since 2.6.31 you can fix the cell-id with the command 

iwconfig <interface> ap 01:CA:FF:EE:BA:BE

Actually I have seen Linux-wireless drivers work properly in ad-hoc mode 
before station mode became stable (who needs station mode if you have proper 
ad-hoc mode, anyway ;-) For anything supported by recent Linux-Wireless 
drivers chances are that ad-hoc works flawlessly. (As long as there are no 
binary-only firmware bugs...)

Hall of fame: (Not a complete list, add your favorite drivers, if you have a 
solution for problems mentioned here, please share, some info I'm providing 
may be outdated)

Atheros 802.11abg with Openwrt version of Madwifi driver (note that the 
vanilla Madwifi does not work) Supports ahdemo mode, and range/MAC timing 
settings, and many other cool things. Only supports PCI/PCIe/Cardbus - no USB

ath5k (Atheros 802.11abg) - use a recent version of the Linux kernel >2.6.28 
and compile the newest compat-wireless sources against it - no USB

ath9k (Atheros 802.11abgn) - use a recent version of the Linux kernel >2.6.28 
and compile the newest compat-wireless sources against it - no USB

iwlagn (Intel 4965) - I have this card in a Lenovo T61, works excellent, but 
there is a problem with suspend/resume (driver/card doesn't wake up properly, 
so I unload/reload the driver) Haven't updated the driver recently, may be 
already fixed in recent compat-wireless

Working, but some issues:

Everything USB-based that I know has at least one problem :-| Some stability 
issues may only occur if you have a mix of different drivers/hardware in your 
mesh. 

rt73 - kind of works, but AFAIK there are problems with the ad-hoc neighbor 
station speed table. Problem is firmware/hardware related AFAIK - closed 
source firmware. 

zd1211rw - Zydas chipset, now property of Atheros - not fully stable in my 
tests, seems to be firmware related - closed source firmware. Also problems 
with ad-hoc neighbor speed table.

ar9170usb - Atheros 802.11abgn USB - a promising candidate, open source 
firmware, driver development in a relatively early stage and therefore 
probably not stable yet. I'm currently testing it some more. Expensive.

Looking forward to your additions/corrections. I'm very much looking forward 
to get the first proper working USB driver! Would be brilliant to have!

Cheers,
Elektra
