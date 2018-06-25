Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 25 Jun 2018 19:29:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180625172919.GA2433@otheros>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2744691.dbA1SKQ1ei@lafayette>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped
 DAT entry purge timeout in DHT
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

Hi Marek,

Thanks for looking at this patch!

On Sun, Jun 03, 2018 at 07:53:01PM +0800, Marek Lindner wrote:
> This patch deviates from our battlemesh discussions in a major point: It 
> appears to cater towards your specific use-case more than towards a general 
> solution. Can you outline as to why you feel the approach below is 
> problematic:
> 
> When a batman-adv node retrieves a MAC-IP address combination from the DHT, it 
> issues a DHT request to the 3 DHT candidates (owners) of this particular MAC-
> IP address combination. Moving forward, those 3 candidates will be referred to 
> as 'global DAT cache'. Upon reception of the requested information the 
> requesting batman-adv node equally caches the MAC-IP address combination to 
> speed up further lookups (the 'local cache').
> 
> Today, the global and local DAT cache are implemented and treated identically. 
> In order to improve the ARP suppression success rate global and local DAT 
> cache could be separated with the global cache having a much longer timeout.
> The network updates the global DAT cache whenever new information becomes 
> available. Therefore bearing little risk of returning misleading information.
> As the network does not take care of updating the local DAT cache, its timeout 
> should be kept short enough to ensure regular updates.

I'm a little worried about the following scenario:

1) Host (A) joins the network and has the IP_X / MAC_a
   statically assigned.
2) Some ARP Requests reaches this host, it issues an ARP Reply
   which populates the DHT.
3) The host leaves the network.
3) Another host (B) joins the network with IP_X / MAC_b
   statically assigned.

Currently, we only update the DHT on outgoing (= into the mesh)
ARP Replies. I'm worried that an ARP Request would never reach
this node (B) during the whole extended timeout, therefore not
triggering the necessary ARP Reply, therefore leaving this
node unreachable over this whole time frame. Which would probably
result in a lot of confusion, I guess.

That is why I was wondering whether it might be better to stay
on the safe side and only apply an extended timeout to entries
created or updated via DHCP.

Cheers, Linus
