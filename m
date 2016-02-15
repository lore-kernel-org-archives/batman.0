Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 15 Feb 2016 10:11:37 +0100
Message-ID: <3296204.f5OVBeuHEA@bentobox>
In-Reply-To: <10971950.7jXMiP8m2i@prime>
References: <OF514CE6A6.70ACFF1A-ONC1257F57.004BE44C-C1257F57.004C213B@phoenixcontact.com>
 <10971950.7jXMiP8m2i@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4031383.BxeCBqxsHI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Prevent mutliple ARP
	replies sent by gateways in bla setups with dat enabled
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

--nextPart4031383.BxeCBqxsHI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 15 February 2016 09:50:18 Simon Wunderlich wrote:
> On Friday 12 February 2016 14:51:32 Andreas Pape wrote:
> > From 2b90abdf53e9ab09d9acfd141c7225de1ae16719 Mon Sep 17 00:00:00 2001
> > From: Andreas Pape <apape@phoenixcontact.com>
> > Date: Fri, 12 Feb 2016 10:05:57 +0100
> > Subject: [PATCH 1/4] batman-adv: Prevent mutliple ARP replies sent by
> > gateways in bla setups with dat enabled
> > 
> > This patch shall make sure that only the backbone gw which has claimed the
> > remote
> > destination for the ARP request answers the ARP request directly if the
> > MAC address
> > is known due to the local DAT table. This prevents multiple ARP replies in
> > a common
> > backbone if more than one gateway already knows the remote mac searched
> > for in the
> > ARP request.
> 
> This patch looks good in general. I can not apply it though, please check the 
> links that Sven posted how to set up your mail client to send patches. Also, 
> the commit message seems to have too long lines. Usually your git client 
> should limit those to ~72 characters per line (I'm not sure about the actual 
> limit)

See SubmittingPatches:

    - The body of the explanation, line wrapped at 75 columns, which will
      be copied to the permanent changelog to describe this patch.

This should also have been displayed when you've checked the patch with
Linux's

     ./scripts/checkpatch.pl --strict 000*.patch

Kind regards,
	Sven
--nextPart4031383.BxeCBqxsHI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWwZZJAAoJEF2HCgfBJntGxBgQAJIh7BUdlfOzEtVzD5VQiOa4
Fh3VbdTodPKRmC8fsPbV1/ayfqxh8hmRlvooIEK/SpZswAFEt/3IN5KzpvOMLety
YiyO9efa9gTtIZYWETv3zmWjBRJLOcAh1J8qsy1GKITQL2kK/52QUNMB2F3Uui1o
VxOQwBHaASv+7rSA42FCGfBhWgStQVcRvbBxSyJk3GgJe84Luau4xDpgif5ob+aK
U73jFxqDEcrDHpU8pLFw9tSFr3uReNUnmLqQDLiBu6/e5i69MZj5hhKmwb6DJGEQ
ktrLTev1Q14FFSZEeaCYziq8TyCkCUpPobuCzpSGu7vwcyKyDFXi7CQukP6Egnbw
H+pkAjzb5WDUjtMTfEw2UHHTCTxxr9KdC253CQEtjaBcUWTVrT7N0qfKexaN2aTf
PTtVSAhQNE+uXqHxkbHj02BMk3GNR7NJyjP1ooNCcoLMtMrXsGgfWRdInNSUrh1M
NQAK1EK7G14vWHbYOkj5KQR212oMQyVoANl0PlzM4Dmbk6eyeEH/XU91HIWIul0Q
wJzYn4a0My12RDDNN5cPkrC/ZBMEP1GXjuBELUIwVLQlnDXg//per8Y/FbEC4RCs
Z88tttUvsTiC+TLMNM9gBl4yGX/SCqtWsD7D/hdqO75l24pef+vdiPnZIoIotjDZ
HvS9wxvd/qDmuofqMBkK
=OdXC
-----END PGP SIGNATURE-----

--nextPart4031383.BxeCBqxsHI--

