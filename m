Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Dec 2017 11:52:59 +0100
Message-ID: <94537663.xTi0rPAMDM@bentobox>
In-Reply-To: <20171119140553.24435-1-sven@narfation.org>
References: <20171119140553.24435-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2597253.nmAlqqjNGN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] batctl: License cleanup
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

--nextPart2597253.nmAlqqjNGN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 19. November 2017 15:05:47 CET Sven Eckelmann wrote:
> Hi,
> 
> the kernel community is currently trying to make the licensing status more
> clear in each file. This is mostly done by adding SPDX license identifiers
> and defining a set of rules how these license related information has to
> be stored.
> 
> I've used this opportunity to also go through all files of batctl (for
> example with FSFE's `reuse lint`) and to annotate the files according to
> the "Linux licensing rules" and FSFE's REUSE practices.
> 
> There are two things which could be seen as controversial:
> 
> * change of batman_adv.h to the Linux preferred license
>   (I am waiting for Acks in the batman-adv patchset)
> * explicitly mark remaining files as licensed under the GPL-2.0

Applied in 007ece3..11b729f

Kind regards,
	Sven
--nextPart2597253.nmAlqqjNGN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlonzAsACgkQXYcKB8Em
e0Z2ZxAAhrCMrP071P4NvbWIxmsBUte7ZRe4OUuhnVPOPcIXFvgO+QAVDUC0VqSQ
RqjjmUTsk9+6c1MPdodRqMaE2yRE4jo6bgZIk7Vq3FKD6Srt0R4c19ObxqTzpxTz
VF1bIAEs7CQ3xVziP2ehqI0rZSQIPj1W6Uxw0kBp0QhBjFYTaswRqvPLtGdk6FNw
0VFKXNb7ehAp/1kuoyO+3rX9D0nOqzau/6517pzJPXWucrxbEBy3QbOb+XkVXr1h
oKjUp0IpMpubZObx4Zb4tiUeYcHklWgY/ic2VKyuMVQNoXQkaMeaPR/h2C2C6FdV
gMQOY5vLKJ+sfXiHkF+hfU1ono0IRPsv5GZ6U9l8xxcxRe3y4Z40jE4ZjvEHH0q8
m2Vf7+CmDV1hv3AitNeayF2iInfh+uyIR9xwxLCo8ae3Jg9njjdvtCeP/vJefzgV
D7jfGsDkukThwKw52kzxm8Tr0J/+4PGHkROSrmWwamz7BtjBYyQmPCsPu0MIES8F
CjHyQ9KPB8yPiYc+GlkynhuSNzwe/hQ5FBPXGRsbAto/p7151B+UzK4HeQ9SCeAt
5mx9tQlbR2CONz7QQiZFPi0NBBeL910hE+lx0b3V4rM7RZZPyVvVa2wxsoVc7zBv
0w3uo8AEeL9q9d9wfUcwead2CyC0Uuniyoq34lfxOvi05P63xrg=
=48vy
-----END PGP SIGNATURE-----

--nextPart2597253.nmAlqqjNGN--

