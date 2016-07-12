Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jul 2016 14:33:09 +0200
Message-ID: <1954516.MjuANSl94h@bentobox>
In-Reply-To: <1468314486-29592-2-git-send-email-mareklindner@neomailbox.ch>
References: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
 <1468314486-29592-2-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1513618.YnVxMkMNDn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: additional checks for
	virtual interfaces on top of WiFi
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1513618.YnVxMkMNDn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 12. Juli 2016 17:08:05 CEST Marek Lindner wrote:
> In a few situations batman-adv tries to determine whether a given interface
> is a WiFi interface to enable specific WiFi optimizations. If the interface
> batman-adv has been configured with is a virtual interface (e.g. VLAN) it
> would not be properly detected as WiFi interface and thus not benefit from
> the special WiFi treatment.
> This patch changes that by peeking under the hood whenever a virtual
> interface is in play.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/hard-interface.c | 85 ++++++++++++++++++++++++++++++++++++++---
>  net/batman-adv/hard-interface.h |  1 +
>  2 files changed, 81 insertions(+), 5 deletions(-)

Most of the patch looks good. But you may want to first accept the netlink
patches and the rewrite the dev_get_link part.

> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index 478977b..6324474 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
[...]
> +struct net_device *batadv_get_real_netdev(struct net_device *net_device)
> +{
[...]
> +	net = dev_net(hard_iface->soft_iface);
> +	ifindex = dev_get_iflink(net_device);
> +	real_netdev = dev_get_by_index(net, ifindex);

Andrew provided a patch [1] which gets the correct namespace of a link. You
should consider to first accept his patch and then use batadv_getlink_net to
get the correct namespace for the device instead of just assuming that it will
be in the same netns as the batman-adv interface.

Something like this:

       net = dev_net(hard_iface->soft_iface);
       ifindex = dev_get_iflink(net_device);
       real_net = = batadv_getlink_net(net_device, net);
       real_netdev = dev_get_by_index(real_net, ifindex);

Could it also be that this has to be done with the rtnl lock held? Otherwise
some of the the information may change while we are going through all the
steps to get the real interface.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/16442/
--nextPart1513618.YnVxMkMNDn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXhOOFAAoJEF2HCgfBJntGiz4P/3wpLMKpyTxzNFJbjbgWU/ZN
se71W3tUyJckdSQ4OirWWS1PMbNp+ipEv78UFC4oTaRYZExpgERjNhoZfZfTO41M
Eed9855NY0fbHQLa/wK/LjEQSIHXZLvJZ/4sK7pSAAJIj7euxxLRlju5wYsNWie8
J1fSq3LljV68qGaeC7HLLg3o8tgZfA/iXIbdYeO1Z7+N+VVV3tsOKZUeKrFc8lB2
voHfKoVYjZZR7Rl64C3AW89MVQxaRn+Jqkbni9alP7OS6M108Dt4RXBXtAXGak/U
9Wxhp4PtXoNY9vHzC2pyZSvcvEcabE1uVb7rQ/twQaaTPpWbEtsbxb4b+Ye6MsoP
zPMGiTyiXfXckTABRtLvGTDxGLZJhtixLqX7C5xxSQxAbjP5n5vlx7CmdsVzrOOv
Za9HkG/XLqZ5FkqEAEmX3ZopKxUsKON4p9w6zUqsXINwKiHlH5kGQNhVivD+fhiw
hyS33dUGpM23+SXu4eLkvrWUpJwxeNQLSN3qbePITdbECWG2QhuuAqEIdMxR1KJU
UZz8/eGK4zxoTpbAV9Lt98gbzaQtj4iwNul5y5B/NdPt6sHAetdhkjKdwah+hgOx
XLGF8ddttqK7BawWaFLPcTOXRpIW2A75Xg1YnasvK3rygSsUgc4jnTWDeaHfuCjA
8dFP/R5g7T0rjdR52Evl
=eng7
-----END PGP SIGNATURE-----

--nextPart1513618.YnVxMkMNDn--

