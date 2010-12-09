Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 9 Dec 2010 22:02:52 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20101209210251.GA4592@pandem0nium>
References: <20101207221351.GA19474@Sellars> <20101208072915.GA8875@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20101208072915.GA8875@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N.-Advanced Multicast Optimizations
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Andrew,=20

thank you for your comments and the review!

On Wed, Dec 08, 2010 at 08:29:15AM +0100, Andrew Lunn wrote:
>=20
> [...]
>=20
> Do you think you could do a search/replace with "multicast MAC
> address"?

You've got a point, we can change that.

> [...]=20
>
> Is this symmetric assumption a problem? Depends one the use case. Your
> PIM gateway into the multicast cloud should be a member of the
> group. It has to receive the packets from the local hosts, so it can
> forward them upstream to the RP, the root of the distribution tree. So
> your traffic coming from upstream should be O.K. However if you have a
> webcam which is multicasting a video stream, it might not be a member
> of the group, since it is not interesting in receiving video streams,
> just sending them. So in this use case you won't have any benefit from
> your scheme.
>=20
> The symmetric assumption is a nice simplification to get started, but
> i think you need to have a good plan for allowing none members to send
> multicast traffic.

Yup, we had a "symmetric" application in mind when designing
this algorithm, but we have discussed ideas to improve the algorithm to
a more general scheme. For example we could detect if a multicast MAC
address is sent to through the soft interface, and then start
sending tracker packets accordingly - this method might need some tuning
however, the build up might take some time, and maybe we should avoid=20
building it up for single packets.

Detecting non-local receivers (like SNMP snooping) appears to be the
harder task IMHO to become more general - you will most likely not receive=
=20
your webcam stream with your WiFi AP. :)

>=20
> Have you considered handing broadcast packets as multicast packets?
> Broadcast is just a special case of multicast.

That is right, but I don't think this is a good idea to use this multicast
approach for broadcast in this case. From a theoretical point of view,=20
this algorithm is a group aware one for "sparse" mesh networks, where the n=
umber of=20
group members is quite small (< 50% of all mesh nodes). If all nodes were=
=20
in a group (as it would be the case for broadcast), the overhead of the=20
tracker packets would most likely nullify any gain. Non-group-aware algorit=
hm=20
like MPR and its variations [1] are probably more suited for this case. But
maybe someone will find a clever workaround. ;)

best regards,
	Simon

[1] http://tools.ietf.org/html/draft-ietf-manet-smf-10 Appendices A to C

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0BQ/sACgkQrzg/fFk7axb6AwCg7oPafKxnSlzdokotHC+K8USr
jUUAoL/mfqwZtP5pByCGLrukX4Gykxo0
=/byK
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
