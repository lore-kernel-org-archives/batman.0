Return-Path: <antonio@meshcoding.com>
Message-ID: <53295F85.9000508@meshcoding.com>
Date: Wed, 19 Mar 2014 10:12:37 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
 <1395216532-31099-3-git-send-email-antonio@meshcoding.com>
 <20140319090316.GH5208@Linus-Debian>
In-Reply-To: <20140319090316.GH5208@Linus-Debian>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LqxncISm8hIJnhm09Lnqennhk4nrCQ9a7"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 03/11] batman-adv: fix multicast
	kerneldoc
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
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LqxncISm8hIJnhm09Lnqennhk4nrCQ9a7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On 19/03/14 10:03, Linus L=C3=BCssing wrote:
> Hi Antonio,
>=20
> Two things are confusing me, firstly:
>=20
> On Wed, Mar 19, 2014 at 09:08:44AM +0100, Antonio Quartulli wrote:
>> The kerneldoc should always use the third person singular in
>> the long function description.
>> Moreover it should always try use up to 80 chars per line.
>=20
> vs.
>=20
> On Sun, May 12, 2013 at 12:55:25AM +0200, Antonio Quartulli wrote:
>> For some reason we agreed on not using the third person while describi=
ng the
>> function. For consistency I'd suggest you to do the same your kernel d=
oc.

I think the situation is a little confusing because there is no clear
statement anywhere.
We agreed on not using the third person in the function description, but
we use it in the function "long" description (the one after the arguments=
).

>>
>=20
> Secondly:
>=20
> Why do you only change it in multicast.{c,h}, why not changing
> things everywhere? For instance translation-table.c sometimes uses
> "Returns", sometimes "Return".

Because these patches are meant to be squashed with what you already
sent before I send them to David (this is why I have create dos many
patches with different Introduced-by clauses and this is also why the
patches are targeting next). They are not going to be sent ad a
standalone set of changes.

Yes, we could "fix" all the kernel docs, but this should be done as a
separated change. If you are willing to do that, please do :)


Cheers,


--=20
Antonio Quartulli


--LqxncISm8hIJnhm09Lnqennhk4nrCQ9a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTKV+JAAoJEEKTMo6mOh1Vdm8P/2q5XWIGgYGFvqHm+HzLL6RP
/R5mhtn4VsRbnHNpuOe1lVbpNziXEPj5K76/oBGc9i02zZ2xQkKjIdbO+5N22Y83
ctj6d6HQpiPAKFh5X2RoGB20p/L/9SsaH6dOrDtP18SRIVi7LG/dUGz+4UncTl7j
vgK4xnq6krOx3jSMy+G/zUTIaorO1mUU/eHXLQ1/8wfkfLkXXs/aIj/oZfnRQYm/
CaMXw9d4Rbp7GdcVT195R8wjkzAftsv7uvyvBIpAs32B1jvD/EBhaWTDSVTWwSTt
eVohk4VsOOmQh4elTFzX3v3SsCNH0nrFPwiG9476LY3qFCcpprqjs7wEiMP8/IqI
EDh04rFWJiM5/VrwVqOUZid74nzYJgk5PSHL3YwvJ0JUcwhLOWBVelpQuio7gdpS
PH9aD8h5XyMoUeMubOzL/D8yYZQLYa2fxbxsQ81gRP0usDrk2enIvh55C7h5ki+1
ULgJoYl97aBEWPMqx66yik5t7xyklhd3Xcx7oq3dE3Lf73yDfZmG6X+smzrgouTU
7I8DA6M9wnaBZ95dqGq34zVMzer71nilZOe1oXq3fNFBlnLpULH/PrXkkcnsdEza
e/PtOyopE6aJ6ZnFYrVoXjc96e9UgLN6G65tbVJT8QmV2bckPK5BD+loSy0TGtRd
xWaOLkE1jKZJ0ooSDRw9
=Xo6X
-----END PGP SIGNATURE-----

--LqxncISm8hIJnhm09Lnqennhk4nrCQ9a7--
