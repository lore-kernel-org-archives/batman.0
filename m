Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 26 Apr 2010 11:24:13 +0200
References: <1272237853-26242-1-git-send-email-sven.eckelmann@gmx.de>
	<201004261659.20055.lindner_marek@yahoo.de>
In-Reply-To: <201004261659.20055.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2244420.Us7KMsATQ4";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004261124.19573.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Update pointer to ethhdr
	after skb_copy
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart2244420.Us7KMsATQ4
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> > @@ -1106,6 +1110,7 @@ int recv_unicast_packet(struct sk_buff *skb)
> >=20
> >  		if (!skb)
> >  	=09
> >  			return NET_RX_DROP;
> >  	=09
> >  		unicast_packet =3D (struct unicast_packet *) skb->data;
> >=20
> > +		ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
> >=20
> >  		kfree_skb(skb_old);
> >  =09
> >  	}
>=20
> I was about to commit your patch when I fell over these last 2 changes. I
> can't see why we need them. What did I miss ?

They are not really needed, but just wanted to have them in for later usage=
=20
and to have it more consistent (otherwise copy and paste easily leads to fu=
nny=20
effects for some people which cannot be reproduced by the maintainers). So =
it=20
could be removed in recv_icmp_packet and recv_unicast_packet if you prefer =
it.

Best regards,
	Sven

--nextPart2244420.Us7KMsATQ4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL1Vu9AAoJEF2HCgfBJntG7VMP/iWuovSI6CeIa/K7Bu56lZ+R
kJF4cg1SyoRW0qLxZ2mjZWkFldlEYhmM57kwQSgG3LvZsQicZc537G5QXmVXJavn
YNCGFWTCEu6CUALMFTb/afJbuQMpQtI8DdVBPhLLtIb2mVNmv7BC326ryAsjkCyQ
tNi8CZhDMp8a9BMrNLUdOFb0rhunlsgJmDYitHwl5lEawT3Mo7DVuhenqeCERqa+
/7lcchuPMEc4QgShk8myeOH0qubqSuM9V36OIyuYspkM3Qq3SNw1Ib4TQmmCLJaV
WL6uarhXBJ2KyM+Bz6gvmhUmtdH29xAxA9fzvNyRRxnJtqEW7barKZCzDrqRLr9Y
iGhnKnnI0jVSDkPDKSIroQ7FTqpyaKB2eVwPF4fpb/0U+7hNTaDh6vv9lkSqmeiV
iPSDZOpY03+hc0AZywaQuRGrb3zJDPyl1NjRh1sTE+CVE5TgZOUWK519CerjXHi7
pjJ65UNFfXifCxnUUZHlGmegrGEHnAERO3yWF2uaayvF1r7X91eNCrqM9ky6lqT3
s0Seo8RMXW/BQOh5zOUjCA4Zr0SxIlYAGr/4mI3P0uH/mGmmP1vuzDwGk8EOmQO9
1SRGzIfH5hPf90Xp4wdXw+AOkP09z3MAYCoDuessIRcr23FpPl1Hm3TvWPT/BmzP
RzVMTd+/Dp6f0OWC3096
=q6rq
-----END PGP SIGNATURE-----

--nextPart2244420.Us7KMsATQ4--
