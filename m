Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 28 Mar 2016 21:11:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160328191128.GA2772@otheros>
References: <56F5AF2F.6060904@t-online.de> <6005839.o5jWIFZeG0@voltaire>
 <56F934F9.5000508@t-online.de> <11401348.Kx9RpUz81r@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11401348.Kx9RpUz81r@voltaire>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

On Mon, Mar 28, 2016 at 10:43:39PM +0800, Marek Lindner wrote:
> Can you provide insights  as to what that means and whether or not
> tinc/fastd 'export' their internal state via an interface flag or
> something along those lines ?

Oh, that's a cool idea! Similar to the flag "MULTICAST" you can
see via an "ip link", to have a flag like "TRANSITIVE", for instance,
right? (and a net_device flag, configurable via ioctl if I don't
mix up the internals)

mac80211 could unset it by default for adhoc interfaces or if
ap-isolation is enabled. tinc, fastd or OpenVPN could set or unset
it on their interfaces depending on their specific configuration.
ethernet drivers would have it enabled by default. For bridges
some more thought might be needed, what to inherit from the bridge
slaves on the upper bridge interface.

Safe and transparent for the user. I like that idea :).
