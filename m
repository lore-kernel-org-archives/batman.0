Return-Path: <antonio@meshcoding.com>
Date: Fri, 1 Nov 2013 13:36:10 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131101123610.GR970@neomailbox.net>
References: <20131101075558.GI6252@medion.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1Sa0i77dkqaUxqYg"
Content-Disposition: inline
In-Reply-To: <20131101075558.GI6252@medion.lan>
Subject: Re: [B.A.T.M.A.N.] lost connection to a client / Q:
	transglobal-table
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
To: b.a.t.m.a.n@lists.open-mesh.org


--1Sa0i77dkqaUxqYg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bastian,

On Fri, Nov 01, 2013 at 08:55:58AM +0100, Bastian Bittorf wrote:
> in my small office-network we have _often_ the situation,
> that my laptop 8-) has no internet. if this happens, i can
> connect via ssh hop by hop and can see, that the network
> itself (wireless/wired) is working, but the 'routes' are wrong.
>=20
> here the transglobal-table in the master, my laptop is '00:21:6a:32:7c:1c'

what is master?

[..]

> the interesting thing is, that my laptop seems to be reachable via
> *:02:22 and *:00:13 - the 2nd entry has no hash (?), but 'batctl t 00:21:=
6a:32:7c:1c'
> outputs *:00:13 as originator. from the topology, it is impossible to be
> near this node, so no roaming can happen AND i can see on my laptop,
> that there was no roaming. the situation recovers without interaction aft=
er some
> minutes. the transglobal table does not change, but 'batctl t 00:21:6a:32=
:7c:1c'=20
> outputs the correct *:02:22
>=20

Here[1] you have an explanation about the translation table output.

My guess is that you have more than one node connected to the same LAN and =
BLA2
is properly enabled but some kind of L3 tricks on top of batman-adv is crea=
ting
confusion in the network. I'd suggest to read (if you have not done it yet)=
 [2].


[1] http://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batma=
n-adv-network#translation-tables
[2] http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance=
-II


Cheers,

--=20
Antonio Quartulli

--1Sa0i77dkqaUxqYg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSc6A6AAoJEADl0hg6qKeOYw8P/AjYYkF24naTgvoW/tnntUyx
DSsh4VLptIIXGJUg9Hmo1L8527zorDA4BPwOpjuQiqKLSsebelA3alR3RjqM1Ydv
Z2Oyr3CKyUZPJEduexE+NEK4N2B+xH6hjxoFwItNqw5ap2Q3UYu7k7fCGanUDrnR
3cTy0i0EGgKB4z3j/svsbNsocN5ZvcdMLJ8SwPYo0L9fiiSBuFbw6+Xewr0mylQU
H31n6mGrpjFqy0DE5N7ez5yhRxMOSjvScAHwWj5ncTd/SwXfWP1GW5MBBGxy7OBr
0jDt1zFeStAbb7uuu4ZoUgwO4paTjFaqQgjvudXI5jUuoWX3MwWscgKFCFnivEJZ
ACTiMjgK0manZkBBJlDQjVz/2Gf+eHiRjAr4vRlp2uvgPATm3BRCgU1L30OAy1N6
RlqiT1oXQ5TRJ5/rdqORVdC2oiJcI6zIbJ090ShSxfO9goQsXLnbi54uysNe66eO
cFVtjLaKyB0s6ULtUVC1RflVZRsooqc9hshgREMPOnPvm6hw1CQsG8xPudANcB/s
/e2mvDHli0On6WIdLc2T8/6nJwFV402fkBpp+qjsM4qLGna8vuZr94tA/xfZJ2Ru
QSuq0Bs71ZFrrtWUGBwQ3K3w3aJHnS/8dQSypjjkpelQRp1BYpS46SXRWdaI0fr0
Qn35e5cPTzkr3YMoqKSU
=IZL4
-----END PGP SIGNATURE-----

--1Sa0i77dkqaUxqYg--
