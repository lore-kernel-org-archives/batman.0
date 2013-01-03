Return-Path: <ordex@autistici.org>
Date: Thu, 3 Jan 2013 10:54:10 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130103095410.GC27589@ritirata.org>
References: <1355570082-19574-1-git-send-email-ordex@autistici.org>
 <201212261808.51135.lindner_marek@yahoo.de>
 <20130102074813.GB27589@ritirata.org>
 <201301021944.21367.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <201301021944.21367.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: postpone OGM preparation
 to sending time
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


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2013 at 07:44:21PM +0800, Marek Lindner wrote:
> On Wednesday, January 02, 2013 15:48:13 Antonio Quartulli wrote:
> > > > @@ -468,6 +442,7 @@ static void batadv_iv_ogm_aggregate(struct
> > > > batadv_forw_packet *forw_packet_aggr, memcpy(skb_buff, packet_buff,
> > > > packet_len);
> > > >=20
> > > >  	forw_packet_aggr->packet_len +=3D packet_len;
> > > >  	forw_packet_aggr->num_packets++;
> > > >=20
> > > > +	forw_packet_aggr->own |=3D own_packet;
> > > >=20
> > > >  	/* save packet direct link flag status */
> > > >  	if (direct_link) {
> > >=20
> > > Using "|=3D own_packet" isn't strictly necessary because
> > > "forw_packet_aggr->own" isn't a bit field.
> >=20
> > Well the point is that here own_packet could be false, but
> > forw_packet_aggr->own might already be true, so I didn't want to destroy
> > the original value.
>=20
> Good point. However, your "solution" is far from obvious. Either you make=
 it=20
> more obvious or you should add a comment.
>=20

Oky. Will try to make it more clear and avoid obfuscated code :)

>=20
> > > Did you vigorously test this code ? Especially, multi-node with multi=
ple
> > > interface setups are of interest. Also use different orig intervals to
> > > ensure it still works everywhere.
> >=20
> > I will try more topologies and in particular different orig intervals as
> > soon as I have the possibility
>=20
> Ok.
>=20
>=20
> > > The thing is: Throughout the code you can find the implicite assumpti=
on
> > > of the first aggregated packet being an "own packet" (if
> > > forw_packet_aggr->own is set). Therefore, you have to be very careful
> > > changing that logic. One function you definitely overlooked is
> > > batadv_iv_ogm_send_to_if() but there might be others.
>=20
> You did not comment this section. Hopefully it wasn't overlooked ?

no, it wasn't. I simply silently acknowledged your comment :)

>=20
>=20
> > > > +/**
> > > > + * batadv_iv_ogm_send - prepare an send an own OGM
> > > > + * @work: kernel work struct
> > > > + *
> > > > + * Prepare the OGM and immediately enqueue it for sending
> > > > + */
> > >=20
> > > prepare and send an own OGM
> > >=20
> > >         ^^^
> >=20
> > well, technically it is enqueued, not sent..
>=20
> Your kernel doc states:
> batadv_iv_ogm_send - prepare an send an own OGM
>=20
> Therefore I proposed a fix:
> batadv_iv_ogm_send - prepare and send an own OGM

oh, right! I just read the line above your comment, not the rest.

>=20
> If you wish to reword it altogether that's also ok for me.
>=20

mh, maybe. Thanks=C2=B2


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ5VVCAAoJEADl0hg6qKeO7psP/36WH0oKzxE/QxtheuAdEVQn
Y6besqhN3cjXjWNinb/oipF4lwrXk38ocoANOUdeHAG6BjjbpuBLwbb4hU0AMxVx
ScGdi+YhU9AgTxzCm5MsrcW24HIyjzcLwOP4vi5vR7IWybYWHHOpF7tKbHsBqiCg
ji55ZfvvsIKGy7vwMO60JY5I31LYQ87o/xszO1SsrUhRomw/537kdpD8xyxw8VGV
6cGf8ijQ8JFCXULCfj8PyMhsFFXF104riNL3tKPHpSKzeqN+L6Q/6ltj2LV9QbFA
wthijYRGYrx9aY2ptsYl7HiiIBVuY31ypRH5ev3UpwZuoceVSaARmXoJIxseaicw
byvlqfeOJCPzXtf/hQ+Q7e61xcBldQcIcg6sLzY5CUCiHTJ3qBA6FuaYFlsPM1L2
zG16TkozcCDvIsWnhswXvV8kyHxPitrseNVnyVnXsp4oy/zw12W8QRFi/JMwjxen
3LbtZCwGlOqujbV3fIxkQJ5zqnGywhlhGaiq/qY4DXspZhvUPHnQsgA3re1WgTaj
2EIiwjsYfaRGyEV1Co3Tjqk6pvC4Pfm/u5H6k+BpyFaH6p2G5ebGbl7/Pl/2hAuW
+eHfpKuSlD7fQGQ5NsD9vjTMtqz+LHXc5snm7FErm8ov7zzE1uaT95V2SGI48S48
tyPU3+XzRxzHzFWk7YOT
=hf8q
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
