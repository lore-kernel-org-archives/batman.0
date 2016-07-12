Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jul 2016 17:50:27 +0200
Message-ID: <2046441.Yi1MnWNqWl@bentobox>
In-Reply-To: <1954516.MjuANSl94h@bentobox>
References: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
 <1468314486-29592-2-git-send-email-mareklindner@neomailbox.ch>
 <1954516.MjuANSl94h@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart35825868.myyBom9W6q";
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

--nextPart35825868.myyBom9W6q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 12. Juli 2016 14:33:09 CEST Sven Eckelmann wrote:
[....]
> > diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-
interface.c
> > index 478977b..6324474 100644
> > --- a/net/batman-adv/hard-interface.c
> > +++ b/net/batman-adv/hard-interface.c
> [...]
> > +struct net_device *batadv_get_real_netdev(struct net_device *net_device)
> > +{
> [...]
> > +	net = dev_net(hard_iface->soft_iface);
> > +	ifindex = dev_get_iflink(net_device);
> > +	real_netdev = dev_get_by_index(net, ifindex);
> 
> Andrew provided a patch [1] which gets the correct namespace of a link. You
> should consider to first accept his patch and then use batadv_getlink_net to
> get the correct namespace for the device instead of just assuming that it 
will
> be in the same netns as the batman-adv interface.
> 
> Something like this:
> 
>        net = dev_net(hard_iface->soft_iface);
>        ifindex = dev_get_iflink(net_device);
>        real_net = = batadv_getlink_net(net_device, net);
>        real_netdev = dev_get_by_index(real_net, ifindex);
> 
> Could it also be that this has to be done with the rtnl lock held? Otherwise
> some of the the information may change while we are going through all the
> steps to get the real interface.

Maybe you can add ASSERT_RTNL(); in this function. The caller of these
functions (see patch 3) have to make sure that they take the rtnl_lock().

batadv_is_cfg80211_netdev could get the rtnl_lock because it is used for the
elp code (which isn't inside the rtnl_lock, right?). But the call to
batadv_get_real_netdev in batadv_v_elp_get_throughput from Patch 3 still has
to be protected.

Or you could create an extra function which takes care of getting the real 
device for batadv_v_elp_get_throughput when it is a cfg80211 based one 
(otherwise returning NULL). This function can take care of getting the lock. 
Then you can also drop this
batadv_is_cfg80211_netdev -> _batadv_is_cfg80211_netdev change. Of course, you 
have to re-arrange many things in your patchset.

1. create batadv_is_cfg80211_netdev
2. introduce function that returns the device when it is a cfg80211
   * make use of it in batadv_v_elp_get_throughput and use it instead of
     batadv_is_cfg80211_netdev
3. introduce batadv_get_real_netdev
   * make use of it in your newly created function of patch 2
   * don't use batadv_get_real_netdev directly in batadv_v_elp_get_throughput

Kind regards,
	Sven
--nextPart35825868.myyBom9W6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXhRHDAAoJEF2HCgfBJntGCL4P/20MjBUp4LjW7wo1g0Gb7Lro
BRcOlNK5CM7ooWhSvmGE6PNwXtrFU4Ys7nfDDmytPARWVM1ko8BvrmR42vlZ58KX
djjjVNHTcI+20akuM5BOApltUliA4u0aG37lMm9tqGJY/8YpgOK5J7HQdgJAGnJU
4NSNNCFG3xDgDS6b+bWe8u8yk3es6GArMpV9/I1TQLekcJ7ee8dhDeWvdz9eZ8/C
HScvZgjJq7yPVJQBtg9AWPtdTYOBNfP/ycL2xZjJoMY437J4+3CF4Aqf/TVKdtYK
nFtjsMjEPKwW3YJKI0fHsrG+ORG3HJaBU9nUS44jo0+Ce5NDpdoEihj0nDKAUrP4
Psunl9o3HyyPmTKUpHe8MEDGalqv2l98Um+6tJkSK8JAwcqA39AHPl8Hls3GMe+Q
YwDOlm/+LjJP4qP99z0/LuERSVwpFzWULdlKOyXb2xBwyfmrN38XBW3wAy9sZdbq
2DYXTLXGULVEbZi+CC0uU5cwkv4rfSoTLUom4IMPAc4XozC5XcJtrVjPmHvXraAQ
e3BuZcK7/a5AiHJ6sAb2MiNkFK1RCvd8xWk+8DxlcPshvx9g5ptkwiOPypULnQsk
rDtEdzVS+IdpuUpqwg6IodyHzE6ogyo8T0MtXBXne310UBbu8aYDkDlhgwbUp5OP
fUoGC+jAFDpuJmGI1k2i
=PgnG
-----END PGP SIGNATURE-----

--nextPart35825868.myyBom9W6q--

