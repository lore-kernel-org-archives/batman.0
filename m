Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 29 Jan 2017 14:15:32 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170129131532.GD6468@otheros>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
 <7073965.bG8vkJTefB@sven-edge> <20170129130959.GC6468@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170129130959.GC6468@otheros>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH 0/6] batman-adv: broadcast packet
 aggregation
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

On Sun, Jan 29, 2017 at 02:10:00PM +0100, Linus Lüssing wrote:
> For instance the VPN tool "fastd", would add additional
> headers in sizes of up to 86 bytes (40B IPv6 + 46B UDP+fastd) [1].
> Therefore reducing the number of broadcast packets by 2.79 should
> reduce the effective multicast bitrate of:

[...]

[1]: https://twitter.com/ffhhnoc/status/787771192853798915
(Diagram regarding encapsulation overhead with fastd + batman-adv)
