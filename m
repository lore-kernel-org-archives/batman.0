Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Mar 2015 17:48:52 +0800
Message-ID: <10359698.ZMgJnZYhvM@voltaire>
In-Reply-To: <1419594103-10928-23-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-23-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5870415.3gP5g74giM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 22/26] batman-adv: main,
	batadv_compare_eth return bool
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart5870415.3gP5g74giM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:39 Markus Pargmann wrote:
> Declare the returntype of batadv_compare_eth as bool.
> The function called inside this helper function
> (ether_addr_equal_unaligned) also uses bool as return value, so there is
> no need to return int.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 16af734.

Thanks,
Marek

--nextPart5870415.3gP5g74giM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVAA+EAAoJEFNVTo/uthzA2xIH/0QR+FOuIGIPe7LkUNqMuh4s
EXwLudCPnbPj4pM5bCz3+Jf6CeQ1Pjf7QlCV15ieVRe1CuSSesT9ryHsSc6EGLvy
6ePLJtLav6Nmd7ddHmOcyEW3vervqScEBs+2BOtB8HVqE9zk774G7tXgnD5JR0Kf
y/5/kVe2fi+Jk0jlLgCuD4/P+X0nN6ADUc3TBRpuaN/pkK9H5whLdCvurKAZedhd
D/LDUqGYqQeRyu/gH+7GnGofFLJOPS2clKQnIR41Z3GPffRHHUB8mFz7B90+aURA
dcdwEj3vBWB9GryvAxz/y7EPk7BwIUcMWEM6oOMqrMxP9Oo/iBKQzse9KRDbYaQ=
=5Bxf
-----END PGP SIGNATURE-----

--nextPart5870415.3gP5g74giM--

