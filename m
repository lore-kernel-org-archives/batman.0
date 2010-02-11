Return-Path: <x@muc.ccc.de>
Message-ID: <4B740D82.3030101@muc.ccc.de>
Date: Thu, 11 Feb 2010 15:00:34 +0100
From: x@muc.ccc.de
MIME-Version: 1.0
References: <4B6F288E.8050406@muc.ccc.de>
	<20100210024321.GB2112@Linus-Debian>	<4B7301BC.7080809@muc.ccc.de>
	<20100211023909.GB6493@Linus-Debian>
In-Reply-To: <20100211023909.GB6493@Linus-Debian>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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

hi!

Linus Lüssing wrote:
> Argh, okay. I guess, you had batman-adv on your laptops already
> running and the wifi interfaces up when starting batman-adv on
> your laptop, right?

possible, i did not check whether bat0/wlan0 was up or down on my laptop (2nd one wasn't running) when i loaded the batman-adv r1568+patch module.
so i tried it again, after making sure the laptop (and nothing else) was running batman-adv.
but immediately after echo ath1 >/proc/net/batman-adv/interfaces the kernel paniced again.
this time, right before the panic, i also got:

foo:<6>batman-adv:Adding interface: ath1
foo:<6>batman-adv:Interface activated: ath1

(i didn't remove the foo: when patching, but i did add the ifdef printk undef printk).

> If I remember right, then you were saying that you're using the
> 8.09.2 release of OpenWRT. Otherwise you could have activated
> "Compile the kernel with symbol table information" under "make
> menuconfig" --> "Global build settings" to add some function names
> to those nice numbers :)

i guess this needs a kernel compile, just compiling the module after setting these options will probably not work or not help?
i can't compile a kernel for the box because i wasn't able to find the config and possible patches used to build the cambria kernel, so i'm currently kind of stuck with the released 8.09.2 binary kernel...

regards,

	Chris
