Return-Path: <antonio@meshcoding.com>
Message-ID: <53B66226.7030304@meshcoding.com>
Date: Fri, 04 Jul 2014 10:13:26 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
 <20140701085027.GA2341@Linus-Debian> <53B29AFF.2070405@meshcoding.com>
 <CAHxBzxW7PCytsQKk-RyuaXVkAz4oqEJGvJE-HFBh=sn56UQP-g@mail.gmail.com>
 <53B39F7D.6050001@meshcoding.com> <53B3A519.6000400@meshcoding.com>
 <CAHxBzxU-Ly7f3avbANrDw-WJ3dxh4TdW78f1qX+zmpoTg0wu3g@mail.gmail.com>
In-Reply-To: <CAHxBzxU-Ly7f3avbANrDw-WJ3dxh4TdW78f1qX+zmpoTg0wu3g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H30im264oCqH26JHM3Es2ru55vX8NNoT4"
Subject: Re: [B.A.T.M.A.N.] Roaming issues in basic network
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
To: Simon Wong <locborgtus@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H30im264oCqH26JHM3Es2ru55vX8NNoT4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Simon,

On 04/07/14 09:36, Simon Wong wrote:
> I am guessing roaming might not
> trigger a deauth on the client.=20

at least a disassoc should be sent.

> In any case, we can't count on deauth
> being received anyways.

of course, but we should rely on the layer below being working consistent=
ly.

>=20
> Hypothesis:
> It seems as if the wireless driver/hardware has an internal forwarding
> rule. If the AP interface thinks it's got the client, it'll forward
> data internally to it and batman never sees the data and thus can't
> route it.=20

this is exactly how AP mode is supposed to work: if source and
destination are connected to the same interface unicast traffic will not
be delivered to the upper layer but will directly be forwarded to the
destination.

> But since the roam happened and another node has picked up
> the roaming client, translation tables updates are still triggered and
> states are still synchronized.
>=20
> What do you think?
>=20

Looks like there is a problem at the wifi layer. batman-adv here is only
playing the role of a generic Distribution System. The current behaviour
would break any other backbone that you would have instead of
batman-adv. The inactivity time getting reset when the client is
connected to another AP is definitely a bogus behaviour and points
towards a wifi problem.


At this point I would suggest you to involve the linux-wireless guys
(they also have their own mailing list) and to try describing the
problem to them. What I can say here is that batman-adv seems to be
unrelated..

Cheers,


--=20
Antonio Quartulli


--H30im264oCqH26JHM3Es2ru55vX8NNoT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTtmI0AAoJEJgn97Bh2u9e9uAQAI7oSkQlkbS8CnF0rqiVt+OB
IBpF6rez8iy70rdmv4sKk8cb7Tzg0DdZCCfRnJfjQFrh1tEq535Slq4wC6IoUQzM
AR6qmfH/jZUWKMAIdIon6NJzPyG+P60JG5PuZvuAtktmdSU3VndwdRklAgZgpW56
wUlUi3q0cCTJNRcFUZC8ErxJ1sWMw+1bpTYe/qbPbNUjwFAUd+bAzsMQTCXNKzyh
p/5YF28Xb03UiJs+uhvHqdHOcn/+BUfQNDPFz/ikZLMwWI13BE2q8oUj9R29KihA
FCJ7qF3ZV+JMCrphbC2KhKhoUwq84C0MLp8yHclt1x/w7iDOTBjGRwDSaDsAloJf
bx/SxmtRIMqgjLMuh2dB4Z+AjCwVMqkUHbqUqRsdv04kBTEXj2QNg7WB/Bmk7syy
GjiCo2fvg084Sh0/zJw2htWEtlDHj+jhMfXII3QDZLFpGxr6ZlL8KPkn9oVCz9bZ
vPdtzxPTpikKuM+DEzvOkK26cC/nM7A+SpK6s9tV7dEO61JLjSYL0m2nE9QvbTSS
OixJKswY996NAkeYijmqFLQqTjLNH0HihgPncKzdii47+643iEjCj6KXR7gqwj83
gvCDi5du2MMzYQVIRsPy2tPienAMBd6DNQEg+yOR44loPrb2DRoT6X+ywVclhhQO
gh8uoeagpQ6vuT1j0oB5
=KRDr
-----END PGP SIGNATURE-----

--H30im264oCqH26JHM3Es2ru55vX8NNoT4--
