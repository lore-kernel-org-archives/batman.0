Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 16:01:27 +0800
Message-ID: <1571436.PpFx5574Ye@voltaire>
In-Reply-To: <1447082453-13117-2-git-send-email-sw@simonwunderlich.de>
References: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
 <1447082453-13117-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2245781.k2azsYApXP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: purge bridge loop
	avoidance when its disabled
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

--nextPart2245781.k2azsYApXP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 09, 2015 16:20:52 Simon Wunderlich wrote:
> -BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
> +BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR,
> +                    batadv_bla_status_update);
>  #endif

Are we sure this is correct ? The post function is called whether or not there 
actually was a change in the setting. The check in __batadv_store_bool_attr() 
is this:

ret = batadv_store_bool_attr(buff, count, net_dev, attr->name,
                                     attr_store);
if (post_func && ret)
            post_func(net_dev);

Let's ignore for now that ret should be changed to check for '> 0' to avoid 
calling post_func() in case of an error. The return value is always non-
negative unless the input is broken. You could enable BLA while it already is 
enabled which would reset all claim tables. Is that intended ?

Cheers,
Marek

--nextPart2245781.k2azsYApXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSt7XAAoJEFNVTo/uthzAnXgIAJ1DmVe0JAXyBxy+xraM+B65
4QyPqSVXzUdClpG4fcYsHhtU0khDfYDgjkUM3iCf+LNGULMSLbBHLsTz//CPgml5
7Yvzgr3+BU/xxxLIWmrKLoKyVttX4bYTWYtLZ3TTAVb1M9pMVWuBbAqRHCDTgHOR
s2oQzUVavWDSjg0r94a+Fuael5fsX0W4C0TRmWKXaa/coV+p977GZdncoLwjbJfG
7KvKtvkNuos0xFdSVVgEInKHUxTkvHArh3YfHVot5eND8Hg+f6m0eCVWC58+j7ma
B6RAFKMXLKT2Y+Xt3hh9a/wuYyGkxk63Hqy/RwcPCC4NZTghGuvS8Ny8/QlH1aQ=
=lDPO
-----END PGP SIGNATURE-----

--nextPart2245781.k2azsYApXP--

