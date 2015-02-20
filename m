Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 Feb 2015 19:56:12 +0800
Message-ID: <7679509.IB7arj1Sb8@voltaire>
In-Reply-To: <1424375741.18211.4.camel@perches.com>
References: <2621923.3aVJ40SYcy@voltaire>
 <1424375741.18211.4.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1729219.WsknuV7282";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] checkpatch: CHECK: No space is necessary after a
	cast
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
Cc: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>


--nextPart1729219.WsknuV7282
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 19, 2015 11:55:41 Joe Perches wrote:
> > Can you make a suggestion / patch for checkpatch to better handle this
> > case ?
> The "sizeof" test in the current script doesn't work.
> 
> I believe the patch below works with no false positives
> but <shrug> it's perl regexes against odd coding styles
> and weird macros, who knows for sure...
> 
> I did run it against drivers/, net/ and include/

Your perl-regex-fu does the trick!

Thanks,
Marek

--nextPart1729219.WsknuV7282
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5yDcAAoJEFNVTo/uthzAn3AIAIHu0D4OlH+tyWFp/ML0U8dx
C6V2RJBlDrpfX4mL4lRgzVIbjnEoVnvX7u+F9gh1s9IVhI0CQg/R0mIdxg/U7QIF
GkCwgarhdnrfJfeNpe8L4v8986HDH7oA0IKmGxMC1e/fOCO3QHaxMITuhqtlpOHP
XWQC4q/wueVg4TXb5/AoVpi5YwsZL5nanCXTn1ILhhZ9u3JqjheWquO+4gCIApmL
MSL+F1ZSLJXg0jHihiPEjffMcRPuNYPfFnZx1HLeTly7MYNvRWPXZbRpmzchpyw+
EoIKAW//Uo1HivXHYMKRCIg8aWnCQe7CzSIy09mr7iQsCZhgsxbo4uKXYrJ+tW0=
=YdWc
-----END PGP SIGNATURE-----

--nextPart1729219.WsknuV7282--

