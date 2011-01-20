Return-Path: <linus.luessing@web.de>
Date: Thu, 20 Jan 2011 13:52:59 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110120125259.GA14504@Sellars>
References: <9593ED11D39C4938AB059ECE63244111@granch.local>
	<20110120082521.GA14117@Sellars> <4D37F45B.9000106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4D37F45B.9000106@gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Stup batman ADv devel on openWRT
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

On Thu, Jan 20, 2011 at 10:37:47AM +0200, wayne wrote:
> Linus Lüssing wrote:
> >Hi Michael,
> >
> >You have a bridge loop here, you cannot put an interface into
> >batman-adv and bridge the same one with bat0 again which seems to
> >be the case for wlan0. Packets will enter wlan0, batman will grab
> >them, encapsulate it in its own batman header and send the same
> >packet on wlan0 again, reaching another batman-adv
> >node, which encapsulates the same packet again etc.
> >
> 
> 
> Hi All
> 
> If I can jump in here, I had the same prob with batman L3 in wrt
> with the bridge!
> 
> Killing the Br-lan bridge kills everything, I eventually solved it
> by flashing a old kamakaze version : pre bridge version, which
> provides the simple ,
> 
> eth0, eth1 , scenario!
> 
> Wayne A
> 
Sorry, but I don't get it, how are the batman-adv and batmand
bridge issues related? Why should an older OpenWRT "fix" this? In
this scenario I'm 100% that using a different OpenWRT version will
_not_ help Michael, as it is a conceptual issue, not a bug or so.

What kind of pre bridge version are you talking about?

Cheers, Linus
