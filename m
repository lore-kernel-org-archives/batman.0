Return-Path: <a@unstable.cc>
References: <20180509190740.11465-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <fa30c030-a38d-904a-dd2d-a337614460ee@unstable.cc>
Date: Thu, 10 May 2018 21:27:34 +0800
MIME-Version: 1.0
In-Reply-To: <20180509190740.11465-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LFDVDj86dPhYpke8jEYHjhHNlix1P2stw"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Avoid race in TT
 TVLV allocator helper
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LFDVDj86dPhYpke8jEYHjhHNlix1P2stw
Content-Type: multipart/mixed; boundary="o6Sgx0d3OZHmRSUlTIInYeooWh54TZ4yU";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Message-ID: <fa30c030-a38d-904a-dd2d-a337614460ee@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Avoid race in TT TVLV
 allocator helper
References: <20180509190740.11465-1-sven@narfation.org>
In-Reply-To: <20180509190740.11465-1-sven@narfation.org>

--o6Sgx0d3OZHmRSUlTIInYeooWh54TZ4yU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/05/18 03:07, Sven Eckelmann wrote:
> The functions batadv_tt_prepare_tvlv_local_data and
> batadv_tt_prepare_tvlv_global_data are responsible for preparing a buff=
er
> which can be used to store the TVLV container for TT and add the VLAN
> information to it.
>=20
> This will be done in three phases:
>=20
> 1. count the number of VLANs and their entries
> 2. allocate the buffer using the counters from the previous step and li=
mits
>    from the caller (parameter tt_len)
> 3. insert the VLAN information to the buffer
>=20
> The step 1 and 3 operate on a list which contains the VLANs. The access=
 to
> these lists must be protected with an appropriate lock or otherwise the=
y
> might operate on on different entries. This could for example happen wh=
en
> another context is adding VLAN entries to this list.
>=20
> This could lead to a buffer overflow in these functions when enough ent=
ries
> were added between step 1 and 3 to the VLAN lists that the buffer room =
for
> the entries (*tt_change) is smaller then the now required extra buffer =
for
> new VLAN entries.
>=20
> Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")=

> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>

Good catch. Unfortunately this issue was caused by my misunderstanding
of the RCU mechanism when used with lists.


Cheers,

--=20
Antonio Quartulli


--o6Sgx0d3OZHmRSUlTIInYeooWh54TZ4yU--

--LFDVDj86dPhYpke8jEYHjhHNlix1P2stw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr0SMYACgkQB6U8WA7y
zXS6cg/+JShWRSH2It6NfoSt4kjIEY6iTaLLstprAzIy70hmcUer/rZN5efLFbNw
kPWJFQvTQqPDOMDEqniUXOrv+D7Fb30Nn1EoOKmfhV/yrLkErQlU+RwPvrBAwH8W
G1FFfGgsbcTWy3RE5Cirzix0KQtWHU83tG+0sw6VKHChACVC3/vx7vtL5ZNucSxl
3Wr8RBn3jC7d5lZy7Vczqw1WoKFs3y5WTVLmRfS7BORAJumuWvb+4D67QUwBbMzO
jiiGzX3X8IdLgB29X9eWGIf6IEiWkB//RS7cMkqaVOsugMxriD7fJwRHGfwJ/+bU
eKOo8iwDoTO+w0zEGSf8rDs0b/0uoF1CNNbPFWvK7jp/0yNhEWtZr2vbhqQoHHW8
GWxyt0yi1ushKzTaqFvoQmPsbQ1s9v20dS30zC5WwlOuvsJUsAIKhkyufDngzbPE
wx2P/hgRBX5rHtMPkRFwhNOA0X/IY4JhP5YE1nrhrqqI4mNr3A5QaExFiUnRTgGM
z4cn6osF2Ffs1YS18y5yeUnCV3pHdI2hh+JVqr0s3s4FFfR5RHb6p7Q8gMCQ3cD3
nia4ppu+qAE8dYueyImb1oV6+s4fUIa1rikw+RfvZD0CC2LeoHmo/QplmmHHzmFI
AgLhgbyePX47BvyotY2QN2hqZ/0XHDncFvzawT7l36OBe0JzbxE=
=BYL8
-----END PGP SIGNATURE-----

--LFDVDj86dPhYpke8jEYHjhHNlix1P2stw--
