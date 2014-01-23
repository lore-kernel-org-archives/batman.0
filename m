Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 23 Jan 2014 16:21:56 +0800
Message-ID: <2060050.y21VcONmYd@diderot>
In-Reply-To: <1389037044-27530-2-git-send-email-sven@narfation.org>
References: <6312194.LhI8hzXjyH@bentobox>
 <1389037044-27530-1-git-send-email-sven@narfation.org>
 <1389037044-27530-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1613485.gR6ZFDKUPv";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Use libnl to implement mac
	resolver
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1613485.gR6ZFDKUPv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 06 January 2014 20:37:23 Sven Eckelmann wrote:
> It is not necessary to have code duplicated which is already available in
> libraries like libnl-3.0 or libnl-tiny. This is done to reduce maintenance
> and security risks.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile    |  18 ++++
>  functions.c | 312
> +++++++++++++++++++++++++----------------------------------- 2 files
> changed, 149 insertions(+), 181 deletions(-)

Applied in revision 6212797.

Cheers,
Marek

--nextPart1613485.gR6ZFDKUPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS4NEuAAoJEFNVTo/uthzAvpEH/ixBGEZjMRFZwj78gU+EIAYI
wZLcnshAG4B2x1Z7Chv/HjN/LaRTuKk8Y0CShl7WxuOr1PHXHCY41+tMDMNv0LfI
EKw/Om/4zD6NyMXB1pALxkedtOXT3awq7UdBR075IcCeGQC4D0ZhLGBOXsbNlHDM
ZNQrqfIApydKeuQH5IXY1v4UJlQCT6rP3fiKVJVWjTTleUHYIZNmxVs/ff5bcgQn
xvOjL66zfI9euhNDKW3aRJW95a1sAZIPP3m0xYjjnLo2iMRYm9TNKLDd7FXI45dJ
msWLCACCOwuozrI7V4zUHXTc+RSXYwvTYQ6dDsTvwiZ+qJ7ONuvsTyFnlKJyz3U=
=2ldp
-----END PGP SIGNATURE-----

--nextPart1613485.gR6ZFDKUPv--

