Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Oct 2017 13:46:49 +0200
Message-ID: <6677419.eTnXb6rzk9@sven-edge>
In-Reply-To: <20171021094546.8299-1-sven@narfation.org>
References: <20171021094546.8299-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1540062.bKFrxQjjMu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use inline kernel-doc for
 uapi constants
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

--nextPart1540062.bKFrxQjjMu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 21. Oktober 2017 11:45:46 CEST Sven Eckelmann wrote:
[...]
> +
> +	/**
> +	 * @BATADV_CMD_GET_GATEWAYS: Query list of gateways
> +	 */
>  	BATADV_CMD_GET_GATEWAYS,

Just wanted to mention that this could also have been written [1] as:

	/** @BATADV_CMD_GET_GATEWAYS: Query list of gateways */

I was just lazy and formatted everything as multiline comment instead of 
checking whether any of the entries would fit in a single line comment.

Kind regards,
	Sven

[1] https://www.kernel.org/doc/html/v4.11/doc-guide/kernel-doc.html#in-line-member-documentation-comments
--nextPart1540062.bKFrxQjjMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlnrM6kACgkQXYcKB8Em
e0bOJg//ZvZ+R3iCKb8rQVzKrBhZLNB4DUTePe87GuSCPlvQ75n+wS6Iy5an4/kL
eS9z/YSSEIwXyhRy5X+LipN0osE9UJ9Hpk/mB3EMXsbMOTxqXBM58/V6hIcbh9wP
IMeMZzuFKNKZGuucmxC5dMSKRSQ7I34QbKL9V1W6p2BmrxCIxb4oSFf5RBVcxuAT
YPXbEXOrb2c+A4A/I1TszpSPUqX+ZkKbz+dpEwsTXpDcrePFT/UdIJVdt8y6ZBn9
hvRgr5NmfatkIOj8IfF1Ww14DksQQtWu3bw5xxYoj+SeLbYNnQYj1RGM3Maiyu6M
BLJCl/SlZIo86elbMvlYg1VtpJpR8fW4V3O5Uvb1GgPxTyTR8DDvB4PqwqOfEecE
5FvNxna88Jl67ldTQCNwYVmpqOtctAUlyPYs1uW2XM3uf1UvSPDLQR0549o5zGUj
X0zhaexeWRa7jvlPDDCm9leum8c2LzuzEYq/kf6X65cVp6iV+1OTifxzDG2dvkiV
1imaqb/FVFIfXwerYQ5qp/qqYNAb/T7bZh8dm8vgztAItaWMl8maPjltDEkZVMoI
Hbrw+JdBGYwylFvzdB6yOeKr6D1lrbPxA8ktF+Ut1l+l6ctVVkNAHChF/xItrhMK
V2q2eXhwFhoeUC6BAJLGZUJLrNC+AdR8FWGh6WKkbpANw8bXdOI=
=Vlu8
-----END PGP SIGNATURE-----

--nextPart1540062.bKFrxQjjMu--

