Return-Path: <antonio@meshcoding.com>
Message-ID: <532723A3.5080808@meshcoding.com>
Date: Mon, 17 Mar 2014 17:32:35 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
 <1395062574-28291-3-git-send-email-antonio@meshcoding.com>
 <53271F2E.6030307@hundeboll.net>
In-Reply-To: <53271F2E.6030307@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DSfCwjRRvsxoicGmIRuePBbsJXA1uCblH"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 03/11] batman-adv: fix multicast
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
To: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DSfCwjRRvsxoicGmIRuePBbsJXA1uCblH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 17/03/14 17:13, Martin Hundeb=C3=B8ll wrote:
>> - * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if w=
e are
>> - * out of memory.
>> + * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM if =
we are out
>> + * of memory.
>>   */
>=20
> The commit message says you wanted to use third person singular, but
> your change keeps the "we are out of memory" ?

I meant to use third person singular when talking about the action made
by the function.

Saying "we" in the code/comment is generally not nice..maybe should
change that as well.

Cheers,


--=20
Antonio Quartulli


--DSfCwjRRvsxoicGmIRuePBbsJXA1uCblH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTJyOsAAoJEEKTMo6mOh1VEd8P/3thSTxTGcmhCwM5aLEhT5yL
QoXaGs+9PpVUaYhRhSyPD/0wipk9G8EfXkRw3WA9tdDQAHThMQjdvkQC4fBdd9rJ
bOYR3c1Lh0oCkmTH0HgJ5z+sTH3HooPIgdlEdu/w93Lspv6W7f24nad2m2DHxovz
vMz7WCpK7YZfjTB3mNHcyAF2IPg62cu1vUdvLD9AENT5CndBo0xLnB1Bf464+c9l
L/RBZ2GtLSlLjkYw8bni1rq6c+G9A34JpYeuar5kCQFY6rLaOxWYvP/xYCbKI6sx
S3untQWi2lumpbwGbPhoJgZitgMK+sWm45ccw4Fubhe0m0byW4xU4fCaoUmtmqm8
55cRm+pcSVDQgenxbDP5Ob/VZZgQniyqD3f4/zt+V5C2xckX39yGHhrey5K6JrBu
65FvNwbd/zOL+NFmCDmhVPAY8Gvq85taC1EJzO4ixBbnUJven61vDUEjgPWZxEWK
leUZpOMHyQg4tx/RfLMFi1UMBqg2gY2PtJqvc+Xr5POEVJK9zsi6Y024HFOALC+T
/wyCnTfTN8i8vv7FUr73JUt6NvZ+pyNxFYaulqDiA0nTAyKRCqHjNtQU0x0FBXE/
TQz+sOa5RDJy60rLMaCAFB3mbjS/35Ju8EQ8ZrTsygJEpTCcDXYwlcnLTZtMUHe6
42chS7l2AERbg/rHqBQi
=mvuv
-----END PGP SIGNATURE-----

--DSfCwjRRvsxoicGmIRuePBbsJXA1uCblH--
