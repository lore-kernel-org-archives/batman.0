Return-Path: <antonio@open-mesh.com>
Message-ID: <5373DB83.2080006@open-mesh.com>
Date: Wed, 14 May 2014 23:09:23 +0200
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>	
 <1397484205-20905-2-git-send-email-antonio@meshcoding.com>
 <1398440696.4152.26.camel@jlt4.sipsolutions.net>
In-Reply-To: <1398440696.4152.26.camel@jlt4.sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ORNF4T3Ao6Kb63UtdaHlwbCU0hE1I7DmI"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] mac80211: add
	get_expected_throughput API
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
To: Johannes Berg <johannes@sipsolutions.net>, Antonio Quartulli <antonio@meshcoding.com>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ORNF4T3Ao6Kb63UtdaHlwbCU0hE1I7DmI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/04/14 17:44, Johannes Berg wrote:
> On Mon, 2014-04-14 at 16:03 +0200, Antonio Quartulli wrote:
>=20
>> +	u32 (*get_expected_throughput)(struct ieee80211_sta *sta);
>=20
> This isn't nice - it forces drivers to conjure up a value.
>=20
> You should probably at least allow returning 0 for "no idea" or
> something.

Yeah, I think so too. Returning 0 as "I don't know what to provide"
should be fine. I will specify this in the doc.


Cheers,

--=20
Antonio Quartulli


--ORNF4T3Ao6Kb63UtdaHlwbCU0hE1I7DmI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTc9uLAAoJEEKTMo6mOh1Vfr4P/0n0mFbSxtiUpVl1EQ6dBUct
+G3Qs1ToZQNQHrqzynWNEc/XIhFZBLX86aYHN8g1jF3ngbDPcbmt/gtSrt/CRZ6P
uifzzAJVbPmN7kWSoU97CtFGrB06lL2jiG2NIflrwl0qbL7/4lphE4KY8Mm8vdWa
45FLAEOvtsO8D6R0YDaNlNFtSAlCopZ0UNcllzoW8bgodoXbfN7ClrM1sIkiJ9gy
aTDI9+C6qNJV8rw3tyxhczuo2VGVGvORExpldwIemogX12lsx2j2zQ7seP7tP/MW
+XHM7wW2XQbBGNHIIEoNV8ultU4MCeJsozIXxnqPVnmgY43yx/rx9LqvhFECQVdZ
XFAoStiboR9cQtDXtHvI/U3Nc40npOIbwL40r1IPV4MlDBUk8dgP1Ji33Ls/uVRQ
89IG+EMPDh2QD0LfrBcfQku9HLjqQ0A6wdO0wLfwPU/U0Cdr6iBdjCaUzbe4BNfn
romgB8B8f7lEn3ClKLEHpXBOttuNA3VXYxHoZ01H64l0p4h7aZSkbJ9FcDKATi8s
Gf67rE71NHwISPSQMbo/MwZ97SmIEdwERlgX730OGAGTVa/FV+LNpO5XSCBKfCBX
BsyFTDtOhlpS6E2vGKquN6ENUWLaFrGe+7Wtffz5h8EjCDj0xmA5cL/Dy/ScUYTC
8wVj62CWtkfAg2LQWz/F
=TpMe
-----END PGP SIGNATURE-----

--ORNF4T3Ao6Kb63UtdaHlwbCU0hE1I7DmI--
