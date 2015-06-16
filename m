Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 16 Jun 2015 14:38:20 +0800
Message-ID: <18875259.tEm7X7ajAx@voltaire>
In-Reply-To: <1434349345-12854-2-git-send-email-linus.luessing@c0d3.blue>
References: <1434349345-12854-1-git-send-email-linus.luessing@c0d3.blue>
 <1434349345-12854-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart40984998.MIqfa9In9G";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Make originator
	capability changes atomic
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


--nextPart40984998.MIqfa9In9G
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, June 15, 2015 08:22:24 Linus L=FCssing wrote:
> Fix this by using the atomic set_bit()/clear_bit() functions.
>=20
> Fixes: 2b1c07b918d2 ("batman-adv: tvlv - add distributed arp table
> container") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>=


If I am not mistaken the referenced patch only touches the DAT capabili=
ties.=20
You should send separate patches for each regression.

Cheers,
Marek


--nextPart40984998.MIqfa9In9G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVf8RnAAoJEFNVTo/uthzAfk4H/2ouJl/j5SmjGT20w2UIGBJc
etD5kP06coFJaKuX1ld3Pi4XWBoTxz3ISBJs0tyN78CynnbGwuIeMGhDqMJ4N0gP
3Lu0MK52O9lD6HxPLlXandIlMtJ/sL/OmF3dyVS4FxbnCq6GwhvT/FEfecxiluwx
cVzI5bzvEjh8NCh7ZrIYKiwGhCmgHr2kZcTvSjgzbdScynaYFBY4v2+pCTw2kLZ+
cl+C5i/CjBLNcXRztxAMLG8fGqejxH+6/TxCfrBLYc1EBCgiRlAjRMEobsCj4uVc
5o+2Wpk3lQkOZ3Ge/jcsmn6wO3uEZW0vdlJuK1lE3dPFpFr0txLY4OtXIArNiU8=
=kmqP
-----END PGP SIGNATURE-----

--nextPart40984998.MIqfa9In9G--

