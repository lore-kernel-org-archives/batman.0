Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 1 Jul 2016 09:30:31 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160701073031.GJ4309@otheros>
References: <1465676873-21545-1-git-send-email-sven@narfation.org>
 <1465676873-21545-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1465676873-21545-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Use broadcast as fallback
 for gateway replies
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
Cc: a@unstable.cc

On Sat, Jun 11, 2016 at 10:27:53PM +0200, Sven Eckelmann wrote:
> The replies from gateway server to gateway client are usually sent via
> unicast packets. This only works when the destination address for the reply
> is already known to the translation table. But usually the gateway replies
> are in response to the first known contact from a device to the gateway
> server. So it can happen that the TT entry was not yet created.
> 
> The gateway server has therefore use broadcast as fallback when the entry
> is not yet known. This makes the first responses from a DHCP server to a
> DHCP client more robost.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This is completely untested. The RFC was submitted to better explain a
> problem to Antonio. This problems was noticed in real world setups but
> these patches were not yet tested in these setups.

Hm, I'm wondering what kind of overhead implications this could
have in larger mesh networks.

Didn't TT support temporary entries? Could the gateway server
inject them into its global translation table after parsing an
incoming DHCP packet?
