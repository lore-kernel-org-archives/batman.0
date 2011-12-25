Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Dec 2011 23:29:42 +0100
Message-ID: <2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
In-Reply-To: <201112252236.22377.clemens-john@gmx.de>
References: <201112252236.22377.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2869520.MKLsMsfgpR";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2869520.MKLsMsfgpR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 25 December 2011 22:36:18 Clemens John wrote:
> Hi,
> 
> I want to test the  Bridge loop avoidance II with our OpenWrt Freifunk
> firmware. Is there a version that works and can be tested? Which git repo do
> I have to use and what are the main steps to compile it into openwrt?

Simon Wunderlich is the maintainer of the bridge loop avoidance II patchset. 
His current version can be found in his repo [1] in branch blaII (or another 
branch with blaII in the name). It is currently not rebased on top of master 
or v2011.4.0... so you cannot take the patchset and put it in OpenWRT.

A quick and easy way would be to clone the repo, make a diff using
`git diff v2011.4.0..origin/blaII > blaII.patch` and place the resulting patch 
in the patches directory [2]. Keep in mind that this patch removes some 
changes that were added before the release of 2011.4.0 and adds some other 
ones which were already applied in master. His next-blaII branch is also a 
little bit newer (includes some fixes for smaller problems) and could be a 
better starting point.

You can find the patches merged after the release of v2011.4.0 and not part of 
the blaII patchset using:

git log --no-merges '^v2011.4.0' 8dd0e9973429c80f52483e8045862f61a74b6fd6

I am sorry that I cannot give a perfect answer right now.

Kind regards,
	Sven

[1] http://git.open-mesh.org/?p=simon/batman-adv.git;a=summary
[2] https://dev.openwrt.org/browser/packages/net/batman-adv/patches
--nextPart2869520.MKLsMsfgpR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO96PWAAoJEF2HCgfBJntG7n8P/2VHpOC5FwTDRRiBWvxtPBJd
z19iIQx7TKf7wDIcqKvlvR4cvvVu3g+kld+tV0KmOuH1Z2wydRpQXQC/6C7ruBpH
0ir5iySLlg+otRNzcvvyxnbOeyymrm/ZZVK4ZGSDXXiXUyK62iTZzPSK+h5M8MZb
Q9yJHib5M7kCu1Ga6UpwuTYZnO+cs4rQzrM7S0eFf+la6QOWL6zU7aWl9T3J7QKj
kD8DSD399IPf3lkoX2+aPw7Qce6aAaW+RV/ehdv9xpHYoi/3NWBNtCwgDCCH5sun
F1moNjIk3bQ/J4d2RI/O3wbsEbcLrao2luFhI9eVxUMZLwB6Es/0O9MwRjZ2PPJK
LLjEh9L0OGb1v3vr0PqjEKWOzW9XsCReOrdCGPZS26HObqQqkbNVVfImrM9ceg/6
kbX9UE7il35ZQlknpGFdXmVXkWRQ5rYYJ5NotJD1C4k0LjC8qKWJCLXxioKUZW6X
piMlPf+ScnNGEnsfvf2+SU9H/uuC7mlpjCoj27JxEQBvIawTJi3NQaO/Y4Fx3Y1X
dC1ZLVWbMWJeC13QHR5UQnCsG61wmvSWn22oe82uSfMur7D+a9nxc1Gdy0jfmYIW
Kw/crTrpdtSppeM9H/dV6WRJFUF2VqHVieQ0qWuLFn3Gusx0OMfp3Nsin4QAZjFe
Gb9dXncZxBePSSf+i4kx
=nanA
-----END PGP SIGNATURE-----

--nextPart2869520.MKLsMsfgpR--

