Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 6 Feb 2019 20:08:14 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190206190814.GC1442@otheros>
References: <20190119155626.6414-1-sven@narfation.org>
 <1895931.G10psR3j26@sven-edge> <20190205192409.GF777@otheros>
 <3348534.ntHJrxh9jc@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3348534.ntHJrxh9jc@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
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
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>

On Wed, Feb 06, 2019 at 07:20:25PM +0100, Sven Eckelmann wrote:
> On Tuesday, 5 February 2019 20.24.10 CET Linus Lüssing wrote:
> [...]
> > Another thought, if all this is too vague for now... 
> 
> Yes, it is to vague for the integration in netlink :D
> 
> > what about
> > ommiting the BATADV_ATTR_MULTICAST_(MODE)_ENABLED for now and use
> > a reverse logic instead? Like
> > BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, defaulting to false.
> 
> Would be fine for me. But it is rather odd to map this to the batctl 
> multicast_mode. But the name is explaining quite well what it does
> and you can later rewrite the batctl part.

Ok, will rewrite the batctl part later then. And probably keep "batctl
mm" as a (hidden?) option for compatibility reasons?

Regards, Linus
