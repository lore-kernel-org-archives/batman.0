Return-Path: <antonio@meshcoding.com>
Date: Tue, 22 Oct 2013 08:28:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131022062821.GH1544@neomailbox.net>
References: <52651870.3000001@gmail.com> <20131021122119.GC310@neomailbox.net>
 <800EA6FA-FE6F-4B95-B1C5-0DFAA4CDBF19@gmail.com>
 <20131021131745.GB1544@neomailbox.net> <52655830.8080607@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <52655830.8080607@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Originators with cero TQ
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2013 at 06:37:04PM +0200, Fernando Pizarro wrote:
> El 21/10/13 15:17, Antonio Quartulli escribi=C3=B3:
> > On Mon, Oct 21, 2013 at 01:23:37PM +0100, Bruno Alexandre Taraio dos Sa=
ntos Antunes wrote:
> >> I think its spanish for zero
> > In that case..If I remember correctly you can have TQ=3D0 only for "Pot=
ential
> > Netxthops". If an originator has a TQ=3D0 on the best path then it is s=
hould not
> > be shown in the originator table.
> >
> > However, if you have further doubts, please post the table.
> >
> > Regards,
> >
> Hi all,
>=20
> That's correct. Nodes with cero value (TQ=3D0) there are in "Potential=20
> Nexthops" but there are a lot of them in the originator table. In some=20
> cases, only there is one node with TQ major than 0. Example:
>=20
> 172.16.0.9    0.300s   (196)       172.16.0.36 [     wlan1]: 172.16.0.40=
=20
> (  0)       172.16.0.35 (  0)       172.16.0.22 ( 0)       172.16.0.39=20
> (  0)       172.16.0.33 (  0)       172.16.0.32 (  0)       172.16.0.36=
=20
> (196)
>

It depends on your network. There is no rule saying "there must be more tha=
n one
potential nexthops having TQ > 0". For sure you must have at least one with=
 TQ
non zero (which would be your best nexthop).

> There are another cases, a behaviour that I don't understand is this:=20
> Traffic is being routed using a SINGLE jump (or direct link) very low=20
> bandwidth to its target, but there are many other options with better=20
> bandwidth, however using more jumps/links, why is this happening and how=
=20
> can I control it?

Bandwidth itself is not considered when computing the TQ.
The TQ is computed starting from a packet loss counter.
Moreover the protocol introduces a "hop penalty" which is used to avoid loo=
ps
and to push the protocol to use the shorter route in case of many "optimally
equal" paths.

>=20
> Number of hop are more important than link quality to calculate TQ=20

You can try to tune the value of the "hop penalty" I was talking about by u=
sing
the knob at "/sys/class/net/<mesh_iface>/mesh/hop_penalty". Its meaning is
described in Documentation/ABI/testing/sysfs-class-net-mesh.

This knob decides how much the TQ has to be reduced at each hop (remember t=
hat
there are other penalties too...). You can read this page to get some more
details about the hop penalty and more:
http://www.open-mesh.org/projects/batman-adv/wiki/OGM

However be sure that you know what you are doing when changing the hop pena=
lty
value.

> value? Is there any "well-known formula" to calculate TQ?
>=20

No "well known" formula, sorry. The TQ is the result of a number of operati=
ons
that you can read from the code and use to write your formula. So writing a
formula is still possible but it is not present in any documentation for the
reason I stated before.


> I make some tests changing default class of a client to 3 (batctl gw=20
> client 3) with same results. What is the best client value for a large=20
> enviroment (about 40 AP's)?

the class you are talking about is part of the gateway feature. Be sure you=
 have
read this http://www.open-mesh.org/projects/batman-adv/wiki/Gateways before
going on. This feature does not affect the routing at all.

Regards,

--=20
Antonio Quartulli

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSZhsFAAoJEADl0hg6qKeOSDYP/2eHyhXneKcfMHWx8aZNOkAs
CPhMvNXKzEYYEtl1pXTICl0HRJe8UKRhPZoT0/rq9/GI6JB23L5W+SWKj/3BQtx+
Ki8Q9Warrfom1psxdPX5+OBYi79BEBwp+8ze7wrjX2dimHUvT40f3zdr0TXpqfJI
PdV8UbZzUJHjNUPfg3jj0gErk4f/oW7kIavtTzXyyIRkWI2PEshQM4Mv+G/XIfbe
DDEZRs8BhZmhBtb/n/rhvnEp1Gcwt1mlaujor4Ztl+stpNwixgm8MWUYiI8Xh2Lf
1MZTv9f7XOouiXv3HTwraaKk+HN9VOFoMyc1Yp5FtmB7YFUzJQAsyIBVDFxPPlYN
VYVrucjRnQo9OsQfqOtioLvjAz68oP4bWV6IH6MI9qSgnw0M1EWGZefyxqFDaxId
lzVucerur5UbXIeMV66APBv1efP0TsaT63C/QeDBw4lbJSVfg3xJqBzwbWm35C05
isZSXDEg1wa9UMPFB+sY5jTjScvfLMSo0alVlMEOx1dUctd4fV32gz+Np3v1Vswg
1KRUB4lZ4M69Hj2jEFuNW7Fe26ATIGqZqjzV4kxh7cNm10708h5g3uxVI1sd5hnd
aJOzJCMekZSjNYhzndCXfvBDvrfH79aAqRtq/NjXgOHMOgnx59YQu4MoGuZFDSBl
v15aq/++562BrNEyJojt
=+7h0
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
