Return-Path: <antonio@meshcoding.com>
Date: Wed, 18 Sep 2013 08:19:01 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130918061901.GF3053@neomailbox.net>
References: <CADtP98UYNT7KOg9a1Pc+bozarwxfpNh8E+BG14xbvGX5EQsFVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <CADtP98UYNT7KOg9a1Pc+bozarwxfpNh8E+BG14xbvGX5EQsFVA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Where can i see, sequence number, eq,
 rq for an originator?
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


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Eugenio,

On Wed, Sep 18, 2013 at 12:55:27AM +0200, Eugenio Carocci wrote:
> Hello everybody,
>=20
> first of all, i want to excuse myself, if i write something wrong for
> my horrible english. I am writing my thesis of Information Engineering
> about your protocol.

It's not only ours, but it's everybody's protocol ;-)

> So, as i wrote in the object of the
> message, i want to see where BATMAN-adv save the last sequence number
> saved for a generic originator, and also
> where it puts all the information act to evaluate the TQ toward each
> originator of the mesh.
>

The information exported to the user are visible through the originator tab=
le
(batctl can help you getting that), but most of the things you were asking =
for
(I'm reading the subject of the email..)are not exported at all.

This means you can't see those values from a user prospective.
You would need to patch the code and print them manually (if you are really
interested in that..).
For this you may want to have a look at the "neigh_node" structure.




Cheers,

--=20
Antonio Quartulli

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSOUXVAAoJEADl0hg6qKeOAdcQAKIxoFm8D5czW+aaijUrVgg4
BLg8/S53e8wrG8Q3+coNWMfilM1PRsM+SvpZdDU5ABZPHCi7zCbcjPOmRaKlCrlM
C25AFQj8S7RSUclDY0pPzDO+0Vg2qyJVvewmDuI3EedlQvFXkj5qB4m35aLm2hJI
gu0wALF3YSdc4nrTLaAnd5iULHzrThLtiaRYLcol9lCGXXafAA4yQ7DzkCjF5Wjv
fhs1bQ08q3kznfgyCBrx/0ougUv1JC0DF35tT7TM9NOETLfFrS41DDrpIQaNEPFF
DWN+ToxHj9dgxfr1IUlo7JIXaWCse8puZWF5PTKiAo2SR0oOtZ1ruLYOVBqW3rC/
W5xpaqDfErckz6JeDoZs8hwE8tt2Tsb+tPhjMuJWn9Jw1YA1zLe7Y5GTSvx9o+yJ
vkILalO33jLOdQewyjZejnMGsX8tPWZcw1kDQjuBcfH8w+/Tcw9A/z3MWXb1eP+s
H7jGQ/KXYh2YqCDo5QECcyYArpHaaWy5Pf/++WhcSIoGss+aXFal41ChejHsKtPI
y65xUJMtIV9x6MrVZpWlkVQztFcDDPSUrQtY5UUT99cT1M0wIBG5ALEuXWOe+gjD
+IWtzM2wkApcO3RRTzZ2jB6HT8v7ioGtmZIwgz7RtmXMGLdwRtWBcVyK3SNXIhFS
vS30haxWEtW9pNrEmnMG
=PdzD
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
