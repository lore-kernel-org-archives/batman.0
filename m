Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Jan 2013 19:08:42 +0800
References: <201301131750.39338.lindner_marek@yahoo.de>
 <4026589.NMKdIS16Jz@sven-desktop.home.narfation.org>
In-Reply-To: <4026589.NMKdIS16Jz@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301131908.42800.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] create batman-adv interfaces with netlink v2
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

On Sunday, January 13, 2013 18:00:49 Sven Eckelmann wrote:
> On Sunday 13 January 2013 17:50:39 Marek Lindner wrote:
> > Apparently, busybox "ip link" does not support creating interfaces
> > through netlink which is why I was unable to actually test the code in
> > my OpenWrt environments. If any if you know a way of making this work on
> > OpenWrt or are brave enough to run the code natively I'd be interested
> > in getting feedback on whether or not this works.
> 
> https://dev.openwrt.org/browser/trunk/package/network/utils/iproute2

Thanks! That works for me.

Cheers,
Marek
