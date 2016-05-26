Return-Path: <a@unstable.cc>
Date: Thu, 26 May 2016 16:42:32 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160526084232.GF13048@prodigo>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
 <1464019185-8381-6-git-send-email-sw@simonwunderlich.de>
 <20160526043914.GJ3453@otheros> <8092239.9avV0sWEgV@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Content-Disposition: inline
In-Reply-To: <8092239.9avV0sWEgV@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v8 05/14] batman-adv: netlink: add
 translation table query
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


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2016 at 10:30:15AM +0200, Sven Eckelmann wrote:
> Hi,
>=20
> thanks a lot for your feedback.
>=20
>=20
> On Thursday 26 May 2016 06:39:14 Linus L=FCssing wrote:
> > On Mon, May 23, 2016 at 05:59:36PM +0200, Simon Wunderlich wrote:
> > > +static int
> > > +batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
> > > +			   struct batadv_priv *bat_priv,
> > > +			   struct batadv_tt_common_entry *common)
> > > +{
> > [...]
> > > +	if (!(common->flags & BATADV_TT_CLIENT_NOPURGE)) {
> > > +		if (nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS,
> > > +				last_seen_msecs))
> > > +			goto nla_put_failure;
> > > +	}
> >=20
> > Unnecessary brackets here, maybe use '&&' to skip a layer of
> > indention?
>=20
> I would disagree here. The { } braces make sense because it is not a simp=
le
> (single) statement inside the outer if body. But I am partially on your s=
ide
> regarding the extra indent. But having both in one statement is also weird
> because one is a simple check and the other one is a function call with s=
ide
> effects. So I am not 100% sure at the moment and will leave this untouche=
d for
> now. Maybe Simon wants to add it or I will think about it a little bit mo=
re=20
> about it.

Although having both statements in the same check wouldn't change the seman=
tics,
I do agree that having a clear separation makes it easier to understand.


my 2 cents.

Cheers,


--=20
Antonio Quartulli

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXRrb4AAoJEJ4aZjxxc6bKzM4QALlcSEeDTaDKyHfctptPCxiy
FDVjNi1ereaVNauYl0jLzN0Ihq27p242ZvCtEu7wYkXnDXpzJXCT+kQTFPJAly5u
3aIS4zElE3dKNaIIVoVS3nWVhtdBbA6NkNxAtaPpv2rM+I9sX+gr2pi8Jt5hgI2g
j5sy3VGBVMTl6YX0+uPe02MOsj42owcjVg/7siIrOwIU/jEZeLFCVoUC6F1kjWP1
jgUDBY0dmHwQHb8+dJul3njg+kZSxTG0BojQwVCaEHal6HUEBHBe7GGXk/lBtcwP
rGEZNdKKfKR8LRGMQAsfVpTysz73YMmeiX0U1qNLRMXoAayjNI+hNYdwEzg357fV
LMfMYhCPNu0D4OSQ5hPSPGlkU9T8B92G+uyuGacUXWaPkFAUQ/V3NTldCbKI1yfG
QpFHn+3SXRqCThUHS0UdG7NJ/Wc4vPc8AdSOv2CW0ca5K1QgvDXzytgaeseMtI6G
AOoHn4t9EEZLnTIPRz3Xdw9uFXuNPJZwwmdcfWsf2+gefEyhK9sUqLlxAjFtesGE
0f8NYqO3/Wg4jW0Kd365wutN3keuz9eCQ7ikgjSFaPEsqwQqWEbqtMDdI1JDxRlR
16Hm9Vo677S1rjLw5XcHy5rKXROucOnQAaTuX0ncinhDK4Ws7F3+bE2myk6ocq0w
Yv+bNkxOfh3JoOXNnr72
=JRDh
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
