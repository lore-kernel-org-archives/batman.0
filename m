Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 6 Aug 2009 22:26:21 +0800
References: <200908051533.26117.lindner_marek@yahoo.de>
	<SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
	<SNT107-W36378936CB704146168424A60A0@phx.gbl>
In-Reply-To: <SNT107-W36378936CB704146168424A60A0@phx.gbl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908062226.21948.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv
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


Hi,

> There seem to be 2 versions of advanced batman - batman-adv and
> kmod-batman-advanced, however for the k8.09.1/brcm 2.4 release there does
> not seem to be the kmod driver. So I have installed the batman-adv
> (batmand-adv_r1176-1_mipsel.ipk and battools) there is no batctl here.

batman-adv was the first attempt to write a layer 2 routing daemon. 
Unfortunately, due to the fact that it was written as user space application 
it came with a big performance penalty. We ported the code into kernel space 
by writing the batman-adv kernel module. Since the module is stable the daemon 
is deprecated. The OpenWRT package was removed - not sure why you still can 
install it.

batctl comes with the batman-adv kernel module as it has nothing to do with 
the user space daemon.

The kernel module requires linux 2.6 (nobody backported it to 2.4 yet). Unless 
you use the open source wifi drivers for the WRT you are stuck with the binary 
only wl driver which runs on linux 2.4 only. That is why you can't select 
kmod-batman-advanced.

Regards,
Marek



