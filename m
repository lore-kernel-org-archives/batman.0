Return-Path: <mschiffer@universe-factory.net>
Message-ID: <52453E3F.6080300@universe-factory.net>
Date: Fri, 27 Sep 2013 10:13:51 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <de510a1e7cb175c854734fa07c347f18ac697446.1380181735.git.mschiffer@universe-factory.net>
 <0b55d834953625e28eb8c77b96c08cc0f13448dd.1380184164.git.mschiffer@universe-factory.net>
 <1412297.LnmMWnToDl@diderot>
In-Reply-To: <1412297.LnmMWnToDl@diderot>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AUgSt4RPjCVls237GP9v4J4fxIVNWRvTK"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: set network coding
 packet handlers in batadv_recv_handler_init()
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AUgSt4RPjCVls237GP9v4J4fxIVNWRvTK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/27/2013 08:07 AM, Marek Lindner wrote:
> On Thursday 26 September 2013 10:29:49 Matthias Schiffer wrote:
>> batman-adv saves its table of packet handlers as a global state, so ha=
ndlers
>> must be set up only once (and setting them up a second time will fail)=
=2E
>>
>> The recently-added network coding support tries to set up its handler =
each
>> time a new softif is registered, which obviously fails when more that =
one
>> softif is used (and in consequence, the softif creation fails).
>>
>> Fix this by moving the handler setup to batadv_recv_handler_init(), wh=
ich is
>> called by batman-adv's __init function (and where most other packet
>> handlers are set up).
>=20
> Would you mind changing your approach to adding a global nc_init() / nc=
_free()=20
> and do the callback registration there ?
>=20
> Thanks,
> Marek
>=20

No problem. Any idea for a good name for the new function? Currently,
the init functions are named a bit inconsistently, there is
batadv_iv_init, which is called in batadv_init, and many other
batadv_*_init called in batadv_mesh_init. I'd prefer renaming all those
to batadv_*_mesh_init, but that seems like lots of avoidable changes for
a net/stable patch.

Maybe the maint patch could stay like it is, and I'll add another patch
on top for master that cleans things up?


--AUgSt4RPjCVls237GP9v4J4fxIVNWRvTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJFPj8ACgkQq3qIxbiQM9hqnQCfdiOpkiVpI4BfWUFMNXVnk4Uw
Ky4An16ejrXar0/EoBJeH+Rf8LII6SQj
=YEDA
-----END PGP SIGNATURE-----

--AUgSt4RPjCVls237GP9v4J4fxIVNWRvTK--
