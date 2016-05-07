Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 07 May 2016 20:32:38 +0800
Message-ID: <3201869.Xl0jMmQoV9@voltaire>
In-Reply-To: <1462622057-26286-1-git-send-email-mareklindner@neomailbox.ch>
References: <1462622057-26286-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2187663.eDH8uf1PzH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: initialize ELP orig
	address on secondary interfaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2187663.eDH8uf1PzH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 07, 2016 19:54:17 Marek Lindner wrote:
> This fix prevents nodes to wrongly create a 00:00:00:00:00:00 originator
> which can potentially interfere with the rest of the neighbor statistics.
> 
> Fixes: a4b88af77e28 ("batman-adv: ELP - adding basic infrastructure")
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_v.c     | 10 ++++++++++
>  net/batman-adv/bat_v_elp.c | 31 ++++++++++++++++++++++---------
>  net/batman-adv/bat_v_elp.h |  2 ++
>  3 files changed, 34 insertions(+), 9 deletions(-)

Applied in revision f58a0b0.

Cheers,
Marek

--nextPart2187663.eDH8uf1PzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLeBmAAoJEFNVTo/uthzAyWwH/155d9PsfX0+e8Mf1CBiTRYY
RUwWW4cQD2/qmNIsfVNLP6KlW9ipPqeoEfdAtEv4wj9cFtblAx2rEqXqhWPnZgH5
BbUpwa7dhNx5tCRoMFDI/peaa90ik9RRun/p0quRQJkY1GmHAFE7t9OnXFV8ncMP
04FMvz2XCboH9T0+tPoy74MiB+cZthPjr2tKzZ3M1lVy4ZyCQyjKA4wRljpxglXT
5DgT1XA1vBTbZhpl7uc1IpJi7LPR1lyi96tQ+OOAvjUXadYaHuX5qDqApcUVUZ/B
WKRrDC/HiBQvsDsCNBuE0AO53NUArAp/DRGEQ6ZgTjJQQzW27bQYi+34cMn1R1w=
=S6IJ
-----END PGP SIGNATURE-----

--nextPart2187663.eDH8uf1PzH--

