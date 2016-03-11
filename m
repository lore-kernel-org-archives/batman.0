Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Mar 2016 00:37:17 +0100
Message-ID: <7555039.bGjIxFaJ0h@sven-edge>
In-Reply-To: <20160307143130.GB15541@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <121426826.jDACy89axc@bentobox> <20160307143130.GB15541@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1695062.p6JHqROem5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
	interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart1695062.p6JHqROem5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 07 March 2016 15:31:30 Andrew Lunn wrote:
[...]
> > right now):
> >    dev_parent_net = default_net;
> > 	
> > 	if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_net)
> > 	
> > 		dev_parent_net = dev->rtnl_link_ops->get_link_net(dev);
> 
> Horrible, and i have no idea if it actually works, but how about
> 
> #if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
> #define dev->rtnl_link_ops->get_link_net true
> #define dev->rtnl_link_ops->get_link_net(dev) init_net
> #endif

I have prepared a quick draft of a different idea [1].

You have to excuse me now but I have a longer meeting with my shower to
get rid of the feeling that I have done something horrible/dirty. :)

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/fb7b5eb8c81969dc8bea356d0a3f0b5e72d2da49
--nextPart1695062.p6JHqROem5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW41atAAoJEF2HCgfBJntG9U0QAMfOnyFkE5EwJG+S/gexd1vy
YR4z2Db7VHrd8O16ejbcpEzchsbL9HpzCMJ9Faxcv7qp4PD3p25dbO+XtnPKTLnT
JY4Zf/NCAFHSH32l2Ndp+Cl2eohPR4fTsKYuUJVcrU5nAUT/8fzZnCD6qUVapXr6
pYzJOwReANQKUMshUR8Ccc8ET4dOU2J8bQuewxO9RqvRXsyzi1l5suljRtQ+RTY/
e6pwfNOMqNH+X+963XeqPLm1yAsQdkLv+aC7llIB3fcGzkN9bzCzFQjBy2BLVChu
Hv8nqSyKO//gOvlzC8XcmT1/07Dz+K8bGC3H7a3a4M1tVrkJi9Zv98TkpvC32bv7
1S2oUxVQfQ2L////iZcAQAkuyTNgAUV8EG+Wb8MRRzctXdSlTwNmVp/YDX2wZzWz
mcseG2y04SglHMFecfJlsXe++g/b/BtSBvU502I8bQSOtEDpeROi0B4r/O16hPa0
ATDpLGQ9vbznxYTvjNVEXCxviDdr5iBliqz7/lx7qMNd2xHhcVPAgzJYJdrVtGeY
YWr2o0rKwyZrhWhb6/CtQyJoi6Jn1oV9dckSfpe7JqgDn1wbwFsQ893Hy3yQcLtM
HxjTXWjerylY23KNbUFIdjLgERbIgxkgt2gd7Dz4l9r1laZEBKfOcbm3Iev98Kji
y4HtB4fvZoDqKB5Ybw4z
=E0lg
-----END PGP SIGNATURE-----

--nextPart1695062.p6JHqROem5--

