Return-Path: <jj.sarton@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge>
 <f9e04473-741d-b0ae-778f-2e920b427147@t-online.de>
 <2186536.4Xmab2I7K4@bentobox>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <0203edb3-aa49-e29a-9efd-cd9038d8a141@t-online.de>
Date: Mon, 7 Nov 2016 11:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <2186536.4Xmab2I7K4@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MRO3Bx5j3C0SIdm8GTUQp9dkf2ds9ST1s"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MRO3Bx5j3C0SIdm8GTUQp9dkf2ds9ST1s
Content-Type: multipart/mixed; boundary="Bvf71o6UpmN9jCcifLO94fiHlxU5BFDqD";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <0203edb3-aa49-e29a-9efd-cd9038d8a141@t-online.de>
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge>
 <f9e04473-741d-b0ae-778f-2e920b427147@t-online.de>
 <2186536.4Xmab2I7K4@bentobox>
In-Reply-To: <2186536.4Xmab2I7K4@bentobox>

--Bvf71o6UpmN9jCcifLO94fiHlxU5BFDqD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 07.11.2016 um 09:02 schrieb Sven Eckelmann:
> On Montag, 7. November 2016 07:45:49 CET Jean-Jacques Sarton wrote:
> [...]
>> A major difference with my tests is that batman 2016.4 choose, accordi=
ng
>> to the output from batctl, the gateway with the TQ 240 instead of the =
GW
>> with TQ 255.
>>
>> Translated Interface/Location from batctl gwl
>>    ftun-q0/Q1       (255) mesh-vpn/Q1
>> *  ftun-q1/Q0       (240) mesh-vpn/Q1
>>
>> The normal router choose the GW with the higher TQ, which what the
>> GW attached to the fastd tunnel.
>>
>> Translated Interface/Location
>>    ftun-q1/Q0        (238) mesh-vpn/Q1
>> =3D> ftun-q0/Q1        (255) mesh-vpn/Q1
>>
>> As stated on a previous mail all system what all node had a direct
>> connection to the same GW.
>=20
> This seems to be a completely different topic now.
>=20
> Just as hint: read the manpage for `batctl`. Especially the section for=

> gw_mode.

I allready read this, all node has class 20. So I have to expect
that the gw Q1 shall be choosed by all involved systems.
The behavior is nit deterministic. A new test today show that
the selected gw is the correct one (with the greater QT)

For me this what a possibly explanation of rebroadcasting.
In the mean time I had understood that this is required.

regards,

Jean-Jacques



--Bvf71o6UpmN9jCcifLO94fiHlxU5BFDqD--

--MRO3Bx5j3C0SIdm8GTUQp9dkf2ds9ST1s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlggVV4WHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C21wAJ9Fqe3xZdY4UrfpVZoRy7ICp6U1agCeOXJ8Cnf9liInekbco6D9uuiY/uU=
=wCgE
-----END PGP SIGNATURE-----

--MRO3Bx5j3C0SIdm8GTUQp9dkf2ds9ST1s--
