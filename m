Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 22:07:04 +0800
Message-ID: <1817196.6iOALOOtiH@voltaire>
In-Reply-To: <1434646404-19291-2-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
 <1434646404-19291-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4296669.mWaHqSHY7I";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: Add missing include for
	clear_/set_bit in DAT
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


--nextPart4296669.mWaHqSHY7I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 18:53:20 Sven Eckelmann wrote:
> bfd0fbaef270 ("batman-adv: Make DAT capability changes atomic") started to
> use clear_bit and set_bit but did not add the include for these functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/distributed-arp-table.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 746aecd.

Thanks,
Marek

--nextPart4296669.mWaHqSHY7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVhCIQAAoJEFNVTo/uthzAke0H/1F2FW1sb5n2uUA0B6cmRFjE
pZTSSnrN8Fp/N4/mapbnjAK99mDnrYmVhPnR7wTs8SEmjQUEG40xnRpN66RPFDyS
TEN36ccIJDUv+NbjrHNSD8IYMsQSkFJfkQisXKSZZCGx/NgT2gX9rGM4Nwu14ywp
Dbto1G0Ulkana5vjEVq0h1Y8EDwTjtu2iCzuqmge/yZ5M5pkBvNjKIeZmXxZxpb6
xzf5n4qyjnbz7qiVB2OJfVft/39SoM1KPsH8HC3SO07l27Jxv89jlbZg/OtKhjAf
s6q0Gr4jKuIiRGIxGkjhbUjLKo/XRX5uuhBnLKNlYD3SeJHGjhfzZriP/Se9cpU=
=Egfz
-----END PGP SIGNATURE-----

--nextPart4296669.mWaHqSHY7I--

