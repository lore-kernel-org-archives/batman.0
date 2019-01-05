Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 5 Jan 2019 22:02:36 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190105210236.GT21623@otheros>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette> <20180625172919.GA2433@otheros>
 <20180710202344.GB1525@otheros>
 <9a8ec036-0138-4b9e-566b-a02fbae88f70@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a8ec036-0138-4b9e-566b-a02fbae88f70@unstable.cc>
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
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Jul 20, 2018 at 12:47:35PM +0800, Antonio Quartulli wrote:
> Unless somebody has any objection, I think we could consider as such
> also the "source IP/MAC" in an ARP request and apply the same logic.

Hrm, one potential downside just came to my mind...

A gateway for instance will frequently generate ARP Requests for
various addresses. Sending a message to the three, poor nodes that
happen to be the DAT candidates for the gateway IP might create a
significant amount of messages to these nodes if we were
triggering that for each ARP Request... And all those unicast
messages would basically be redundant as the gateway IP/MAC pair
will already be well populated in the DAT.

One solution would be to introduce rate limiting for global DAT
cache updates... So basically introducing a third timeout for a
DAT entry, next to the global and local DAT cache timeout split.
