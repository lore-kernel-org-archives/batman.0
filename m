Return-Path: <a@unstable.cc>
References: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
 <569F9AF1.5080403@unstable.cc> <6579684.ngYt9xsEyU@prime>
 <569FA717.5090108@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <569FA7D1.9070604@unstable.cc>
Date: Wed, 20 Jan 2016 23:29:21 +0800
MIME-Version: 1.0
In-Reply-To: <569FA717.5090108@unstable.cc>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P4FdqDLCkbbLCCrt7iP2h6CFWSSNRxBRd"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move and restructure
 batadv_v_ogm_forward
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P4FdqDLCkbbLCCrt7iP2h6CFWSSNRxBRd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/01/16 23:26, Antonio Quartulli wrote:
>=20
>=20
> On 20/01/16 23:18, Simon Wunderlich wrote:
>>> this is changing the behaviour.
>>> here now we get a router which potentially was elected during the
>>> previous update_route() call while processing this very OGM. We are
>>> still discussing if we want to do this or not, but this patch should =
be
>>> just a style change, while this is not.
>>
>> No, this is already in the code which is merged into master - we alrea=
dy=20
>> acquire the updated router (see bat_v_ogm.c:547, function=20
>> batadv_v_ogm_route_update()).
>=20
> uhuhuh?! Actually you are right!
> This means we currently send one OGM every time we make an election,
> thus we might send multiple OGMs with the sequence numnber, despite thi=
s
> is still under debate.
>=20
> As far as I remember did not want to follow this approach at the moment=
?
> Am I missing something?
>=20

I was missing this:

+       /* don't forward the same seqno twice on one interface */
+       if (orig_ifinfo->last_seqno_forwarded =3D=3D ntohl(ogm2->seqno))
+               goto out;
+

thanks Marek for pointing this out for me :)

it's all good then!

Cheers,

--=20
Antonio Quartulli


--P4FdqDLCkbbLCCrt7iP2h6CFWSSNRxBRd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWn6fRAAoJENpFlCjNi1MRjM4P/0d4mxmMk/hE/qVgbtC3hjkR
F0DcXgPk27pUEM1mE4VLAOGaG6F5veHqE9w3LvUnzF27BsRFeZkcRh9ijXfSX/ta
L/LHBY8gfsW8tdJ+pCW+mMYbakCnsBZ8HHWIa3rM/uwbYv7HvMOtsdclYs+TfDIl
fntK9rRTLRgnN6BggTIWjp1rUVJPQv13ecQsm1EjXmX6jQCvC2kKw9/IiYcqXsyS
W4xx4LJ2bGSx95OFmjc2GlBECYG5Pyd/i1Loza2pUtUQziJovPK6313raOrWvp02
9CM341L6cwrHWkmTY1OCWGG3+r+MSPTN9CmrBenTSqEOQxtZXz//THDSZZJ7aLey
9StvYrpk5QSWlifflu7UXtVVyfEMGtgaH+h3gQnO9nEqOx10w8HxvitO90ARZlpp
g7Mi+VInB2qImkJxg0fwtOlZOqfuOlvxJIxyHy6sqmdy9MEXBM8NCV6rJ6Vi823a
krWmkRt9cZ0uGP0g2WqVRlIM20CCK8uvhlO1/e95TcBvpvaAh7Oke3M07mLeLddY
1HQGZp3rvmZLYRxU6o/mKy7tz+1GCwcLXzCudRFT55Zgkp7OHu/sfiVdGVk5OGTC
+s2xziFI1EaYoPWvUUTZxjYETzeAoI4hbz+Uc7WGU5bp0KaDxenJBYzR3e3La8A6
dwkT3u1X67yMes0st2jh
=1NSL
-----END PGP SIGNATURE-----

--P4FdqDLCkbbLCCrt7iP2h6CFWSSNRxBRd--
