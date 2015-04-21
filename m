Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 08:04:41 +0200
Message-ID: <8826381.MUao5dBNO2@sven-edge>
In-Reply-To: <2849660.eB6RnOYSlL@voltaire>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1429292430-30883-3-git-send-email-sven@narfation.org>
 <2849660.eB6RnOYSlL@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1782032.2oUAUThM1Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 3/4] batman-adv: Remove unused
	IFF_BRIDGE_PORT live patching hack
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1782032.2oUAUThM1Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> > diff --git a/compat.h b/compat.h
> > index 35e3dbd..9871a23 100644
> > --- a/compat.h
> > +++ b/compat.h
> > @@ -59,8 +59,6 @@
> > 
> >  #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
> > 
> > -#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
> > -
> > 
> >  /* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
> >  #define addr_assign_type ifindex
> 
> The macro is used in compat.h line 55, is it not ?

IFF_BRIDGE_PORT appears in this line but here is the context:


#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)

HERE IT IS *NOT* USED

#elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)

HERE IT IS USED

#endif /* < KERNEL_VERSION(2, 6, 36) */


The IFF_BRIDGE_PORT (which I call unused( is only required in this other 
compat hack when the kernel is >= 2.6.36 and < 3.9.0. But the one I want to 
remove is only for kernels < 2.6.36.

Kind regards,
	Sven
--nextPart1782032.2oUAUThM1Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNeiFAAoJEF2HCgfBJntGh0gQANDRx9F5xQccij5aMBca+org
i/kK7or+YSp6eb8Z5xN+gf/GAHBjCDTFgXpKta+EGEceppE1gbb4GGUmkm7Xli8A
pi/89d6WhR1sVAhIC6YKnW2LNiyvERNlbo6In9uHVyLerq3qt2vn48Tg2ra/gJVu
2J4quwLH9OSVQMATUrC1sbW+hVoE5DUg+hdLarU6rskArhHpNtTfmyD7j/BvfHMZ
D2sv83m3PL7YMNCwIpoP7QIdFhA9zhan9VsanP6gjybY1+5draTPo53r2IUAKBh4
o4BVgRI7UaqW4RO+CcQ00EoUhIG+DUOODetn1b7AAoFkbe45U1HcCWxMxqvmtPMx
Eo/NPz9bMgld0p6HLMcEdkqXEF0HuEA7Mh4Isekyoy0+WGNC9XIfECzpw/GZ4YxM
1R1GS9h/ITEzxTaBBzyu93JrP6Oz3GJzZkQwgVOw6CeLutcbtICWI6DgsyYuOTIB
E8ggkxHEXzD+cg0mnjNZ9GnR7j/C+IqszeZOyQ3l+pFH975h99PUgFd4XEbnHEpF
Bj/5yBN+ecVp6jo7azmk1X0sKJ83AjXzrt+lmcYAOeukE7tA2erCWFLUQUuemaZN
Mscjq6xeIafhEBbUgGBsLqGjTRoWFmdA7QItpcV6qdwuCpzVHbN6XoP+hmz/7LAL
FhPrSBWMcDJhEB/WztBj
=6pRi
-----END PGP SIGNATURE-----

--nextPart1782032.2oUAUThM1Y--

