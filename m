Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: How to give stable MAC address to batman-adv device?
Date: Sun, 01 Sep 2019 08:42:26 +0200
Message-ID: <2134316.j67oi4WX0K@sven-edge>
In-Reply-To: <3af7c293-5b8c-535c-2049-eef51b36da81@exon.name>
References: <3af7c293-5b8c-535c-2049-eef51b36da81@exon.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1639651.6rcDofPDje";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: batman.mexon@spamgourmet.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1639651.6rcDofPDje
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 31 August 2019 21:33:09 CEST batman.mexon@spamgourmet.com wrote:
> I'm trying to use batman-adv to fix wifi signal problems with a few
> Raspberry Pis.

batman-adv doesn't change your wifi signal. So I am assuming that your main 
access point wasn't able to cover the whole area and so you use multiple 
accesspoint and use mesh as a backbone between them.

[...]
> Is there a way to force batman-adv to use a stable MAC address?

    ip link set dev bat0 address XX:XX:XX:XX:XX:XX

There might be a configuration option in whatever configuration interface you 
use to bring up the interfaces.

Kind regards,
	Sven
--nextPart1639651.6rcDofPDje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1raFIACgkQXYcKB8Em
e0b8uw//bBfyoGvDSaWcWZx/Iis7YdoxPPE3f+h0OFn5yvIjYqbA3Q3GoozKoJyb
dp5BPUgLZh7/OCRJIISuUlC2j4KPCEB7IQwyeNEnqXak7WbbDjMhIbdsC98KhVKH
OwmrjrAH+8Jm91LJCoXfJM+iEX/GxeVCaGC8TTciwD0b6Xv8JF2/7Qk6SBSyZAqT
V2Uvf3DyMwotaB7OSazUW74JJytB2fwAmoqqBtrvU5dv8BjysZ39Om6n59x2n9Zm
6Cy83/SUmvTatAxtAEA0DQNq0j3n0semtNi4eQZsFGIVvxuvV4LZv1mkIdeKtj0e
JfBTg4gW6zRYOgRLEq3kzWS5J3nU5NCdY8B5n44Z94a5JYVEJSjMk1Y5xCNKQbKT
ftla9StckhjEN/zNaB5o6N98DYB2q8FaQIe7XqN3pcafyLwSd96JsSShw123+5H/
e2yofjCUrH0kWvVgEt5V7cejO1/hYjRoDlYQNBqsyQYpchTdCFgfDggB0l5JuM4t
lYcB+HAODY6u6uS6hQv5bkEte66m7xX395WWahx9f1C+Te4tAq4zAcUibEZDeFR1
inpQVKs301aw2ndTEi9zjfjLvDQ5urJeaX1V/Hx8fpd/7FXtC5rz14W98TybwBm/
oU0DBotiOxaGOOGqERb1eAY2fpRyUXy053Gp8oCUm/KR9ITodIU=
=/1qY
-----END PGP SIGNATURE-----

--nextPart1639651.6rcDofPDje--



