Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Dec 2016 10:11:17 +0100
Message-ID: <1571316.yNdbsZyCi8@sven-edge>
In-Reply-To: <20161124151101.31677-1-sw@simonwunderlich.de>
References: <20161124151101.31677-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13474821.02m8VbqDZC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't add loop detect macs
	to TT
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

--nextPart13474821.02m8VbqDZC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 24. November 2016 16:11:01 CET Simon Wunderlich wrote:
> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> 
> The bridge loop avoidance (BLA) feature of batman-adv sends packets to
> probe for Mesh/LAN packet loops. Those packets are not sent by real
> clients and should therefore not be added to the translation table (TT).
> 
> Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.h | 18 ++++++++++++++++++
>  net/batman-adv/soft-interface.c        |  3 ++-
>  2 files changed, 20 insertions(+), 1 deletion(-)

Applied in 447df986b83630a92ca9d33903023b7e1b2917f3 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/447df986b83630a92ca9d33903023b7e1b2917f3


--nextPart13474821.02m8VbqDZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhTr7UACgkQXYcKB8Em
e0ZQ+hAAnzT2C2abA+wdhasBqTm337/TlK3xGg1ZgARlAgU9okqq+OEgyI9H10Xf
EbpA2vDtvJEXBtKDqeLHpWH8gfqMXSswoUDYXCMmYU1TC2vgEnQy7gC7mMSBBrUf
iVIji4rSEduIIh4jLAMxiXbXosYc4TAlujwhSWEWsl9vkCoRwiCkAhJnlb6U2C/g
xOQBK2TP0er3m6XCdNjzWLtTEW+HQUjbFgg5BuQwAST03V6mvGZ6DNeexXMWCLfw
DoRo8ILTGaOmU1xhBldiTA2rfAt5naoSLLsgu9Uo9x6kRqsYVJKdKvVZThGqIkc3
0ys3L8ojULvligWGQp+y8wNMZF73IOD3+iS/+jug7dkxLZSnMKI61sbxgUh1KT8v
QQkSAfJ0BT1wzbjqNz5mOo7JQj4T/J4eYXS6fqCTRZs7kpihDzyOUbHtZX9TkSAN
FakFbcAfp24lS8EdbSQtQ2KSLe8atu77lx9MVvtM/EU76kqVX5DBzx0fGVbJyLji
qEp1GchQpVwpugz/lRw60NUT9vMoZ4yTWnZrvXHypyDoax3bbjVJpaS5hL2xG7mQ
0j01esnUk3vYvUJLE6WiK+ucwJrMeQMUEPPUucK+uTXGGgGjSQnGyyXu9PEuNTZG
34L91XDT3daYm2QlzaOvNehBCeV3JNqEZuS6fcOW/DZHZOttvmY=
=PGQM
-----END PGP SIGNATURE-----

--nextPart13474821.02m8VbqDZC--

