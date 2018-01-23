Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 23 Jan 2018 12:46:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180123114651.GC23784@otheros>
References: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2 1/2] batman-adv: fix packet
 checksum in receive path
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

On Tue, Jan 23, 2018 at 10:59:49AM +0100, Matthias Schiffer wrote:
> eth_type_trans() internally calls skb_pull(), which does not adjust the
> skb checksum; skb_postpull_rcsum() is necessary to avoid log spam of the
> form "bat0: hw csum failure" when packets with CHECKSUM_COMPLETE are
> received.
> 
> Note that in usual setups, packets don't reach batman-adv with
> CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
> batadv's ethtype?), which is why the log messages do nor occur on every
> system using batman-adv. I could reproduce this issue by stacking
> batman-adv on top of a VXLAN interface.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Seems reasonable, this change.

I'm just a little confused though: Two years ago someone had reported
checksumming errors with a Raspberry Pi and batman-adv:

https://www.open-mesh.org/issues/224

And they seemed to be gone in newer kernel versions, while hardware
checksumming was supposedly still enabled.

Are the issues reproduceable without using VXLANs (for instance on
a Pi1 or Pi2)? Are they reproduceable on a recent kernel version?
(I guess you tested with a 4.4 kernel?)

Regards, Linus
