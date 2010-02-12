Return-Path: <linus.luessing@web.de>
Date: Sat, 13 Feb 2010 00:45:32 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100212234532.GB24515@Sellars>
References: <4B6F288E.8050406@muc.ccc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4B6F288E.8050406@muc.ccc.de>
Sender: linus.luessing@web.de
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

Ehm, and another question. You said, that there's no bridging
involved. However I see two mac addresses being announced by one
of your laptops (B.A.T.M.A.N., Orig: Azurewav_8b:81:18
(00:25:d3:8b:81:18)):
- B.A.T.M.A.N. HNA: 0a:51:61:16:a1:51 (0a:51:61:16:a1:51)
- B.A.T.M.A.N. HNA: 26:46:d1:f8:8c:54 (26:46:d1:f8:8c:54)
Any idea where the first one might come from?

Cheers, Linus

On Sun, Feb 07, 2010 at 09:54:38PM +0100, x@muc.ccc.de wrote:
> hi!
> 
> as openwrt 8.09.2 still ships with an old batman-adv 0.1 module, i tried to compile a batman-adv 0.2 module.
> the compile worked, the module loads, originators see each other, but on the openwrt box on bat0 tx packets stays 0 while tx dropped obviously increases with each packet to be transmitted.
> 
> the setup:
> laptop debian squeeze amd64 2.6.31.12 batman-adv 0.2
> laptop debian sid x86 2.6.32 batman-adv 0.2
> ap openwrt 8.09.2 ixp4xx/armeb (cambria) 2.6.26.8 batman-adv 0.2
> 
> the facts:
> all bridges and iptables switched off.
> with plain ip on the wlan interfaces, pinging between all nodes works fine (when within reach).
> all three nodes have the respective two other nodes listed as originators, and if all are within reach of each other, with originator=nexthop.
> pinging via bat0 works between the two laptops.
> pinging the laptops via bat0 from the ap results in no packets seen on the laptops' bat0.
> pinging the ap via bat0 from a laptop results in incoming arp-requests and outgoing arp-replies seen on the ap's bat0 - but again, the arp-replies aren't seen on the laptops' bat0 (nor on the laptops' wlan interfaces).
> on the ap's bat0, the tx packets counter stays at 0, while the tx dropped counter seems to increase with each packet that should be sent over it.
> 
> i enabled all logging (15) on the ap and the laptops, but found no hint in there...
> 
> the only interesting messages seem to be in dmesg, saying:
> protocol 4305 is buggy, dev ath1
> 
> so to me it seems like all tx packets on bat0 on the ap are dropped, while everything else seems to work as it's supposed to.
> 
> i then tried to compile the current (r1568) version from svn for the ap. again, the compile worked, but the ap just freezes immediately when i try to load it.
> 
> i thought about trying a newer kernel for the ap, but from openwrt there's a special cambria kernel and i haven't found its config and also don't know what patches might have been applied, so i haven't had much hope for any helpful result along this path...
> 
> regards,
> 
> 	Chris
> 
