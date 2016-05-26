Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 26 May 2016 10:30:15 +0200
Message-ID: <8092239.9avV0sWEgV@bentobox>
In-Reply-To: <20160526043914.GJ3453@otheros>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
 <1464019185-8381-6-git-send-email-sw@simonwunderlich.de>
 <20160526043914.GJ3453@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1821398.18HoV2nkiN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1821398.18HoV2nkiN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

thanks a lot for your feedback.


On Thursday 26 May 2016 06:39:14 Linus L=FCssing wrote:
> On Mon, May 23, 2016 at 05:59:36PM +0200, Simon Wunderlich wrote:
> > +static int
> > +batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 se=
q,
> > +=09=09=09   struct batadv_priv *bat_priv,
> > +=09=09=09   struct batadv_tt_common_entry *common)
> > +{
> [...]
> > +=09if (!(common->flags & BATADV_TT_CLIENT_NOPURGE)) {
> > +=09=09if (nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS,
> > +=09=09=09=09last_seen_msecs))
> > +=09=09=09goto nla_put_failure;
> > +=09}
>=20
> Unnecessary brackets here, maybe use '&&' to skip a layer of
> indention?

I would disagree here. The { } braces make sense because it is not a si=
mple
(single) statement inside the outer if body. But I am partially on your=
 side
regarding the extra indent. But having both in one statement is also we=
ird
because one is a simple check and the other one is a function call with=
 side
effects. So I am not 100% sure at the moment and will leave this untouc=
hed for
now. Maybe Simon wants to add it or I will think about it a little bit =
more=20
about it.

I have added the other changes to my branch ecsv/netlink and will merge=
 then=20
when I have more time.

Kind regards,
=09Sven
--nextPart1821398.18HoV2nkiN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXRrQXAAoJEF2HCgfBJntGrs8P/2L6Rg/MUir4tHUU52kE0oNU
qZKrosrst0aVMNyThozI3fZOr/OIQgav1XmAlO9SKuB4IzVwCg+7uN3vcXnnuDo2
QLk76rMeDmc+wLQ+KU5s/vkK6hRJNL7nk4aZzn1mr0hlqQqoD3Y/D85FoP7lwMFP
Py5hioo5azKsFgqP+jFkP+3E/ywJSLEj8CPGmoW5Q/Mim5u/7yGr/uxl372s5Jhf
3NMLCQaPUfdEY0T9PGRz1swROKXpIO2xYmrsYHbcfA2M1BRUpIX0p36GU95nAnir
705K3EmIvIhd97BoRP+5yE3+/p6QXH3DR+8aRJ/MmBAMBWiwpXcBZilEQzyLfoo2
bLiSkBUfJR1TLLKcfdsiSrGBrhf04u/k+t4No7P5NCqQEUt5SR/aJl+a6GlD7TBv
1/nfDqYy6zH0TnWmwn9dOg/e+lFNVnI5F/npbeuEZsYDi2IhxZCCoe1fVhQxFJSM
m6V0Bi6eGlRIUljiJzxF1NzV+fEx3jy63y4Cm2HIhBBlMYdYZOezWJem+1IywoQ/
dwP6ppZnISzT+J99TSQBqU8gIVlOcYI7ELdS8fmZJxn9xAYSfcb9OlaYzbJQkyp+
Eah0BoMtOxvhsT9aAs0Yu7mo2MJ6VIRpm1EBCQDi0LDsbX8Lp58FYVS8FJXT+NjL
0gYV5gH+DAswW3AJznPO
=TdiS
-----END PGP SIGNATURE-----

--nextPart1821398.18HoV2nkiN--

