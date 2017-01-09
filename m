Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 Jan 2017 08:39:12 +0100
Message-ID: <11969615.XEaDFJMlyh@bentobox>
In-Reply-To: <5a8d0464-db13-e071-f6b5-b13e68c61292@kkk-web.de>
References: <5a8d0464-db13-e071-f6b5-b13e68c61292@kkk-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5687919.18SYbrpDJB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred 2016.5 fails to start
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
Cc: MK <mailing.m1@kkk-web.de>

--nextPart5687919.18SYbrpDJB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 8. Januar 2017 14:19:03 CET MK wrote:
> Hi!
> 
> Alfred 2016.5 fails to start with the following message:
> cap_set_proc: Operation not permitted
> 
> 2016.3 works flawlessly.
> 
> Were there changes regarding the dropping of privileges on start-up and
> running as user "alfred"?

Not really. There was a single change [1] that introduced one more function
which enables+disables the NET_ADMIN capability.

But I've just tested it here and cannot reproduce the problem (following
the explanations from the README).

Kind regards,
	Sven

[1] https://git.open-mesh.org/alfred.git/commit/2310c47f0ad7aadff0adac6f9879bf849c3a6356

--nextPart5687919.18SYbrpDJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhzPiAACgkQXYcKB8Em
e0Y7sBAAjHuFVeFOjJ2FF/dg+PQuwOuptFNfQcmaXlyVuLEGbid39k4scCl7frK5
QCdz8lkNrds3SICscqf7uRzvU/xBE3UwNfPgXaBWr/SlLg6Xy6EV120yiFuhYhDy
faSBUofyAT5tLwrRB6U1dZ3Qo5ind2jsYy5Y628Z6qp7JO2ECIlAhg4QGhKwDTtx
2cAiB5h6lnFTSu+q35Ki8G0ccv99wm8RtYa/lmECgaOcViJlV4IbIrqiL0ig9p2m
YzlVjlvIaDO8Dn40vpg3a0AjvWBAFafAcEt20kCXGuLgN3ZMVked4arYWgC/fExe
17/75qMTfxxxecDoSd4HE3KJTgS0tVoTwSqN2xYCVTPqikD8N43ASnw8EuMAAFbj
NnpU3mdLDc0oTsPtU54d49b7jG4i6rAOIsjN0D1qjILMfGQ284IjQiKsj/xgDlLE
I4szJEr2QubvsHaaDqr0U34ZtKRYwPyYWke3/K/6ZD3iUZYwvIpQ/MFvHarltAig
spnMnjBt3v7O/i8EeG1Sn4PXwhMzgy7Fmte4w0a5WeFOIahsHwgdfS6ktvOhk+cT
vDPtUnr5kMiFyCYF9meFiMu+73eDQa+EBsPOKcPBuzB03yzeL1O0SoufFO/bNcxv
tQIEmvxTcd95Bfu8j0k9+jePl0RmmJXFEuccUwQrvB4UfdhmSuU=
=WN49
-----END PGP SIGNATURE-----

--nextPart5687919.18SYbrpDJB--

