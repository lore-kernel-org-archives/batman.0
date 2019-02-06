Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Feb 2019 19:38:41 +0100
Message-ID: <1556071.oqAPsG2Tpi@sven-edge>
In-Reply-To: <mailman.2.1549464410.7610.b.a.t.m.a.n@lists.open-mesh.org>
References: <mailman.2.1549464410.7610.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5849019.qPd6GMsqcs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory leak in in
 batadv_dat_put_dhcp
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Martin Weinelt <martin@linuxlounge.net>

--nextPart5849019.qPd6GMsqcs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 6 February 2019 15.39.14 CET Martin Weinelt via B.A.T.M.A.N wrote:
> Consume the skb to avoid leaking memory.
> 
> Fixes: 1fd1ce2d383f ("batman-adv: Snoop DHCPACKs for DAT")
> Signed-off-by: Martin Weinelt <martin@linuxlounge.net>

Good catch. I've modified the commit message to make it better 
understandable and to describe the actual problem in more detail.

Kind regards,
	Sven
--nextPart5849019.qPd6GMsqcs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxbKbEACgkQXYcKB8Em
e0bcng//USi7Mv6dApZIan8eZVzFkRtKUf+T++7PPSsvTNgt9oKuI8Z7H+njnZD5
XFJhOzdR1isN6xM3+6O6eVwCVK+nSZYOw/fTqzNhPfZlbLqS1uTWG+x8vkfCJ0Ph
HONrS8zCx9Ehx9AkIlKNqJfbz3UQNt7YytsjpRqz367GkuNZMtpmOn3Yu3efkqPm
+TCHP3fF08KUfvCIhiMOeQYTG6YgKuaucrw7nw+Wp/rlDQsy4uLkpreYvi8ykT1S
U7cEj6nZSkGiHFNxeR86yzP7F5GvLiDw3XTRdHJ2deW+UbaLRXNC+1rASse18MBC
mNQnenFx5iU3F1ORQV/K93Es+nWynUHMjI0AipBpqn7kcqJtPyfqply+bqwUzq98
PRQs4ZRoYAEfMJXvzvDSYPcXwoVaf+9O9HHd+wfXXKPyqRITFDFsHC71AWgmHpnw
IIGc05lY9oIHdecFnbfTUr4X2BtFGQvLrd/pBEzHc/WWDfwktlq+wc693iEiYfHc
XNxghds8pNySIXEDZICYLIC8xIJkOv2LYDL9Nrem8umHgn4FeXZ5JkAIjMmLsuBK
8t7oSsbxcaUy3msyZaYGf5oagJfBuRzeGX4Khypiu/q0SAqpS/YnKlA3qHPOg+KL
iui/pHGLU1RZytlKknYt/cHj1Nkw17btgy1LES+efIxzbIdH1eE=
=j8Re
-----END PGP SIGNATURE-----

--nextPart5849019.qPd6GMsqcs--



