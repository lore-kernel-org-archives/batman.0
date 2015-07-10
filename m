Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:01:39 +0800
Message-ID: <2469507.bAzHbAXoP6@voltaire>
In-Reply-To: <1434890572-3199-2-git-send-email-sven@narfation.org>
References: <1434890572-3199-1-git-send-email-sven@narfation.org>
 <1434890572-3199-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2926961.VvAWGSaUFk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/4] batman-adv: Backport kstrtou64
	for Linux < 2.6.39
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


--nextPart2926961.VvAWGSaUFk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 21, 2015 14:42:50 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * rebased on current master
> 
>  compat-include/linux/kernel.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied in revision 194b581.

Thanks,
Marek

--nextPart2926961.VvAWGSaUFk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn3vmAAoJEFNVTo/uthzAP+4IAI0gX9Z3eF0JwPkaFjO1iVV6
aQvg5B8BgF9ws+MgOr5XZdG1bhVX5uRj/stV/OWj4mEjzQ67kyTXhh0cuoQw6RIF
SAFQWs0pVg+/jT3/c6crpmOqklMOvXMcM+yQUCH+ik0/MIB+O5+hYfXub21DbX7U
mL989VIbDHUkShahleEdxpGKpfXSwlxllTkEe602BTUd9T7Q9py4koRYfTDbp+yl
gyC8mngUpzYr7qiTRNgjXnXJY2alW08tx9AdLfHBD/Z/MLdaBf5hUpnkSqJayQlc
mGyRvhfCSlZLfsRfaS3peRMnAXG4eJqc0y6o01LSUO8OIL+rl8yvP3rhFo0S/Xc=
=m9vA
-----END PGP SIGNATURE-----

--nextPart2926961.VvAWGSaUFk--

