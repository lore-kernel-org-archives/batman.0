Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 02 May 2014 13:06:27 +0800
Message-ID: <6095777.gs8bG3sZPE@diderot>
In-Reply-To: <5358FD91.8090107@meshcoding.com>
References: <1398282390-4677-1-git-send-email-mareklindner@neomailbox.ch>
 <5358FD91.8090107@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2031907.zqZ8vakE8a";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix indirect
	hard_iface NULL dereference
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2031907.zqZ8vakE8a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 24 April 2014 14:03:29 Antonio Quartulli wrote:
> On 23/04/14 21:46, Marek Lindner wrote:
> > If hard_iface is NULL and goto out is made batadv_hardif_free_ref()
> > doesn't check for NULL before dereferencing it to get to refcount.
> > 
> > Reported-by: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> ACK for the change, but shouldn't we have an Introduced-by in each
> patch? Later I will change it to point to the "proper" patch before
> sending these changes to David.

Applied in revision 2ac2c94 (with Introduced-by).

Regards,
Marek

--nextPart2031907.zqZ8vakE8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTYyfXAAoJEFNVTo/uthzA/vMIAIZj0N9CEic8IKtw3ITwBQLZ
HLTDK9MdvWPWBWbXbO9BpgWvwDj7SxHpVZusw36Fce7zmeZ7eUk+QMHVOh40BgLj
nuJpIT9gujjfWt/Wbf82hngzDzahE9fJmq9XrkOGvTFYHKKjcsEsp9VbaonOSEy2
tzlP7RLgV43LIlr7B3nl8LkSYWnrgVrRorrE81s5nSXgZIUF03PG/69RELLqcovr
oWh4wewm9kBnJnVst8YJze6jBDjDUw2O6rVjFC0ssmRvJLtE4bf36JCi54ZdSgf2
KOu8GixS8eIsqZyOfNquDI0fC/mE1Tz5QPB85EzvsWTMRp2fyTiV4PZzlyB+no0=
=cTcq
-----END PGP SIGNATURE-----

--nextPart2031907.zqZ8vakE8a--

