Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 04 May 2016 21:02:05 +0200
Message-ID: <4642303.DsCp7UQf8m@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6252019.Xf3IHxijc9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [RFC v4] throughput meter  on steroids^W netlink
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

--nextPart6252019.Xf3IHxijc9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

I was asked by the batman-adv maintainers to port the tp_meter to netli=
nk. And
I shouldn't do it with the patches from Andrew/Matthias applied but wit=
h only
a small part of patch 4.=20

I know, this isn't the nicest move but it allowed me to restructure the=
 first
commit a little bit. I've extracted the part which introduced the netli=
nk
family + a restructured batman_adv.h. I've also added the part which
introduces the generic mesh information as extra patch (+kerneldoc). Th=
is
added some attributes which I need in tp_meter. But I can also remove t=
he
patch and only merge the necessary parts.


@Andrew, I hope you don't take it the wrong way. I really like your wor=
k and
even borrowed parts of the code for the tp_meter interface. So you are =
now
allowed to criticize the hell out of the changes and request some free =
beer
from=20Antonio, Marek and Simon :). But I hope that you like the adjustme=
nts to
the initial parts (at least a little bit). You would have to rebase you=
r
changes (which I still want to get integrated) on top when these things=
 here
are merged. I would also be willing to do the rebase myself and send yo=
u the
result (so you can add the kerneldoc and maybe make further adjustments=
).

The only "big" conflicts I see are related to the order of attributes. =
But
this was a long day for me and I may have forgotten something.

@the_rest: Do you find the bugs introduced by moving it to netlink?

The one which I know about is the inability to receive signals while th=
e
kernel is doing the wait_event (So the BATADV_CMD_TP_METER_CANCEL doesn=
't work=20
at all). I am waiting for recommendations. The one which
comes to my mind is not to wait for the thing to finish but to just ret=
urn
immediately. The client would then have to some kind of event listener =
enabled
which waits until the thing finished. This approach would also require =
some
kind of session info exchange. Does anyone else have a good idea?

Kind regards,
=09Sven
--nextPart6252019.Xf3IHxijc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKkctAAoJEF2HCgfBJntGK8EQALF2nguMgbHZhn97R61iibKx
QDYBEnB5D+5F121F6/5NH7NRuOpWqL9Vjpth28RAz8Pcbd5Xd/RcoTlSskQdxYOq
m+Z99u+w50OK7eoxVLFigus4gOzFnY4Pkj9BHvDhDbxjA39i0pxHK9Pyyh3FBDpd
gH0t+hUFyY9Xx+Qq/peSx/cs3J/YXHhvZ815ikfddbCm5KEoVMeP/548279JWaU3
lzn8pM3O3K8Z+KTaZj9HMdvwgc/ArtiYxuCAOiV6h1/kupnUAnQpMTX/RgpXhwEm
zWCa+hkiYHgpbDlEQuZivcH8g4x613PhkhJHBxwzWMQ4YSf4eSRr78ElGpnGRA/h
szPtW98unJ6/2Nn9MMhx7IBu/c4VzUXFsTF6ZfYj//iM0h4Lvly/Z4ZDIRgD5hXu
OoqjmgP0JrmpjRlzbTnEY6n1YOAWkW8kUI3Ghoxh/02yl08Fbpo35ZtwTAnAJ+i7
6hLuygMNVIOPv4m6TWomdlnrrG43DbYT7qaZCpqhI63in95UfDkz+bs7Cg5l/5Dw
8ptu9pklnI8Xrpr0DHUoAsFURdV7zhokSCtIGFg8gobJ3EtwLBihiju9e5cu8eoI
WjRt8prEHuPix1MxzmjD5E/++fWzrOvOWD2Qq24NNFyJm3g5aJTsIhCEsgawpt68
EeDxsRxNp6eX2jp4SGgs
=U0/a
-----END PGP SIGNATURE-----

--nextPart6252019.Xf3IHxijc9--

