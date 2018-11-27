Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 27 Nov 2018 14:09:30 +0100
Message-ID: <1633809.n2cPIBvzv7@bentobox>
In-Reply-To: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
References: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2119332.To4uuXvzZQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] patch for manpage batctl.8: Missing description
 of gw_mode sel_class for B.A.T.M.A.N. V
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
Cc: Ruben <freifunk@r.z11.de>

--nextPart2119332.To4uuXvzZQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 27. November 2018 13:43:33 CET Ruben wrote:
> This will resolve https://www.open-mesh.org/issues/366

Please use `git format-patch -1` to create a patch file (of the last commit). 
And then send it via `git send-email --to=b.a.t.m.a.n@lists.open-mesh.org` to 
the mailing list. The patch you've send here cannot be applied with git-am.

Also don't forget to add the Signed-off-by: ... line. And use a proper Subject 
and commit message [1]. And please no "This will resolve
https://www.open-mesh.org/issues/366" in the actual commit message.

Kind regards,
	Sven.


[1] https://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches
--nextPart2119332.To4uuXvzZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlv9QgoACgkQXYcKB8Em
e0ZaHxAAiw5w8MN7rvG1k4SAWXws7tGK63PF+PfFalLHSTw9T3GyaukKBOTJqR9/
eGriF2JRL+wZN7lKnT0HnQtRZ3Fas2WA+RLanu3Lgl/aaVtfAgqZCl49apQrRlnW
1TiNebiIfo7J2L5EXzJt4ekKvn7mUrNYPlLiRTXDeiEEbccW2qX8FfcxAxqODkPT
OtRhuZrEEkXfioXAnYt4yx5LfU93+jZVlk9vRDV0HHyEv6W7yN4P6jUsEsqT63Eo
veCzQl3rlb/0t7zhUw7bBd+Q8QmVKEjhI3lwNciKGW/g7dbgY0BLZwBSkilKnMW0
gDzoJnVZGGr4zPrQ99AGWaNNCMWAOzyFK37QnD1tEtju+GB4k4JyWsix5eosGJYo
8W1NdxMgX1+4WH6z6dOU4mU/VsYIGdicSZqK6OenM7yRigMougCibCIh0AEUIbC0
wml263V5Vdz1AilW5mbdT+pvwGw9LxFFyIOPxl7LQmUk2bF614zopdMEtEoDnux9
ZAf96/a66sfEiaS1UZzgma7LzHZaoWjCi0r6PoNOYEhMQEutx/faxFuPT6ASt7th
7LfRpl3Wji52vb7blwXZIJf8cw3UapL8+M1y17HyCtf32GOe3V+6D0/b/mck6QX9
GFj9VIDtGw7VU9/rNSF34YjTZLrxbC53RsURiHJmOtLj5Sjm5CM=
=/F6A
-----END PGP SIGNATURE-----

--nextPart2119332.To4uuXvzZQ--

