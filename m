Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 7 Jul 2016 12:14:42 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160707101442.GC7076@otheros>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
 <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
 <20160707092436.GH5978@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160707092436.GH5978@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio,

> have you tried applying this patch on one of your servers and measure the local
> effect? (i.e. if the number of BRD ARP req is reduced or not?)

I had queried Martin Weinelt just yesterday, they will test it on
a 500 nodes compat-v15 setup soon :).

> 
> I think that a DHCP ACK packet should already refresh the local ARP cache (or
> not?), thus the need for an ARP request should not be triggered by the newly
> joined client. (I might be wrong, but that's why I ask measuring the effect)

Hm, I don't think that the operating system will snoop DHCPACKs
itself to fill its ARP cache. I didn't see that in the VMs either.

But now that you are asking, re-read my thoughts regarding ARP+DAT
on the Gluon issue tracker. Which made me wonder again, why
the issue occures in the first place (e.g. client issues an ARP
Request first - why does that one not fill the DAT appropriately,
why does it need to fallback from the unicast DAT query to an ARP
Request flood?).

Looking at the code again now, I have a hunch. Question: Why 
does batadv_dat_snoop_outgoing_arp_request() add the MAC/IP source
pair of the client to the local DAT cache only, why isn't it
propagated to the DHT?

Regards, Linus
