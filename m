Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 19 May 2016 22:30:49 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160519203049.GE12565@otheros>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
 <20160519194553.GD12565@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160519194553.GD12565@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
 snooping received ip traffic
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

> Not sure whether it is necessary, or whether there is a check
> somewhere later within DAT. But should we exclude some
> iphdr->saddr or ethhdr->h_source addresses? For instance a
> DHCPDISCOVER usually has a zero-ip address.

And speaking of DHCP, do you (or anyone else) know, whether a
dhcp-server (or its kernel) sends an ARP request before sending
a unicast DHCPOFFER? Or do dhcp-servers usually craft DHCPOFFERs
in userspace within their daemon including the ethernet header?

If the latter is the case, maybe we could/should dat-snoop the
ethernet+IP destination of such DHCPOFFERs in interface_rx(),
too?
