Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 29 Mar 2016 11:50:47 +0200
Message-ID: <3883397.RfpiZdWGix@bentobox>
In-Reply-To: <20160329083717.GA32035@r2d2.s.lihas.de>
References: <56F5AF2F.6060904@t-online.de> <20160328235247.GA4528@otheros>
 <20160329083717.GA32035@r2d2.s.lihas.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2558022.2fitaSXJIL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart2558022.2fitaSXJIL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 29 March 2016 10:37:17 Adrian Reyer wrote:
[...]
> I advocate an admin-settable flag for batman, defaulting to the current
> behaviour. Nothing breaks that way, only batman needs to be adjusted and
> the patch already exists and is tested. Admins can set the flag if they
> think they have use for it and they do it knowingly.

We still need at least one person interested in this patch who rebases the
patch and resubmit its with a convincing commit message.

It would also be interesting if it should be a simple flag or some if
exporting the num_bcasts via $something would be sufficient. Or if the
num_bcasts should be split into num_bcasts_otherif and
num_bcasts_sameif and then exported.

Just keep in mind that this "flag" may has to be kept there until the end
of time. So if there is a need for a new setting then it should at least
be discussed if this is done right and not that someone else needs to add
additional things shortly after it reached the Linux kernel.

Kind regards,
	Sven
--nextPart2558022.2fitaSXJIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW+k/3AAoJEF2HCgfBJntGdTgQAMBbN3Z/fuEwbrCXsTkiAS19
dX1GwlqUKrfZAdP4PokqmfZI81b7EVEA/h/YZdhsYHWqWf17xaLEakHNSBiHdph6
dbjityfRvmmgTT7mgkR9AxFOFKB0ZTYcuvzACTb4C+63UwXBHaBxSAl3dHg2GPbY
z0U/8luJxWTBi3bAWawG3b9orDaKworM/VOoSs7dtFmtAFatc3jgTVnOMMD9s/+d
OqvqJHFQLg9TFI/NYpXudvVBGV5zeO3gsdhiBhfK9+OMYU06YlhZXCBL+PGd0qRe
uYh1L8W7F6shrUdbHxFN4NpVwYAXmbQpa+CMyPdNtYKo1gMkujrVnTEyGwH+yj1i
qiUH7xNFTv7UQiN2fCijmCsnMJy7M67Np5FOdaGOyi8mkv96AlCpTOp4S+GRb+ba
IAyCIyt+ldWGs932OEMxB0eV2o9s/thewMNfDDAJyyDwRZc3iGC8j9lmLcj2fdEw
7ck4S4+RrfJ/cbAgEh4sPs0CUv0cyZbw7QYOQA+ZEPXrVk/5aOKiPtA4Jy44R2+b
shZEKW+6JQTCfnQ4R97uKkhbCkayVBqq89eWSY/oRvq40LB6Uv8UnAVOQK7DE1jy
tOIXiPoNM1hKf+zmRyHhYAUyFK8ZU0TIpGyPlAKXDst9tdjttE2AUGbaoqqe5YYX
C5b04Ke5TdaBPemldgkO
=STHh
-----END PGP SIGNATURE-----

--nextPart2558022.2fitaSXJIL--

