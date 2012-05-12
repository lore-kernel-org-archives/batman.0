Return-Path: <pedroncr@sapo.pt>
Date: Sat, 12 May 2012 16:08:05 +0100
Message-ID: <20120512160805.Horde.1o2CEeanEAJPrnzVjLOmXOA@beta.mail.sapo.pt>
From: Pedro Nuno Costa Rodrigues <pedroncr@sapo.pt>
References: <20120501190319.Horde.oIfHDR3HAoJPoCVnYaUF_lA@beta.mail.sapo.pt>
	<43098025.shuUEIUiJR@sven-desktop.home.narfation.org>
	<20120510224854.Horde.0SO0XL5SZhxPrDfGUeTRkCA@beta.mail.sapo.pt>
	<201205111459.40354.lindner_marek@yahoo.de>
In-Reply-To: <201205111459.40354.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [B.A.T.M.A.N.] Batman-adv simple configuration example
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


Citando Marek Lindner <lindner_marek@yahoo.de>:

> On Friday, May 11, 2012 05:48:54 Pedro Nuno Costa Rodrigues wrote:
>> I'm using backfire (openwrt build):
>> cat /home/pedro/backfire/feeds/packages/net/batman-adv/Makefile | grep
>> 2012# Copyright (C) 2010-2012
>> OpenWrt.orgPKG_VERSION:=2012.0.0BATCTL_VERSION:=2012.0.0
>
> You are trying to mix 2 different branches: backfire + trunk batman-adv
>  * the batman-adv package coming with backfire is working fine with backfire
>  * the batman-adv package from trunk works fine with trunk
>
> Mixing the package with another branch is officially unsupported  
> because there
> are some OpenWrt incompatibilities we can't not automatically handle. It
> certainly is doable but requires deeper knowledge of OpenWrt.
>
> Cheers,
> Marek




hello!

I didn't tryed to mix 2 different branches...
Perhaps i wasn't very clear.

I build the backfire branch and i tested the batman-adv and it worked fine...
I also build (another build completely independent) of the trunk  
bruch, but it didn't worked...

I used the same configurations files on both... exactly the same, but  
the trunk build gave the error:


root at OpenWrt:/lib/batman-adv# batman-adv start
/usr/sbin/batman-adv: eval: line 1: can't
create/sys/class/net/bat0/mesh/orig_interval: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/log_level: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/bonding: nonexistent
directory/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/fragmentation: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/gw_bandwidth: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/gw_mode: nonexistent
directory/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/vis_mode: nonexistent directory

/usr/sbin/batman-adv: eval: line 1: can't create
/sys/class/net/bat0/mesh/ap_isolation: nonexistent directory


and i checked if it was the crc-16 problem livrary, but it wasn't.

I know that's an openwrt problem. Or something that missed me...

I will try to analyze and if it is necessary i will try to contact  
openwrt developers...

Thank you!!
best regards
Pedro Rodrigues

