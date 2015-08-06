Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Aug 2015 20:58:51 +0800
Message-ID: <1759429.XdH2RSf8i1@voltaire>
In-Reply-To: <5952291.mHej69xYbN@bentobox>
References: <1438693798-21807-1-git-send-email-mareklindner@neomailbox.ch>
 <1438693798-21807-3-git-send-email-mareklindner@neomailbox.ch>
 <5952291.mHej69xYbN@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26170182.B3Nt93gHr5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/4] batman-adv: export singe hop
	neighbor list via debugfs
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


--nextPart26170182.B3Nt93gHr5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, August 04, 2015 22:48:07 Sven Eckelmann wrote:
> On Tuesday 04 August 2015 21:09:57 Marek Lindner wrote:
> > + * @bat_neigh_print: print the signle hop neighbor list (optional)
> 
> Just a minor thing: signle -> single

Thanks for the hint.

Applied in revision 3d51cbb.

Regards,
Marek

--nextPart26170182.B3Nt93gHr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVw1oSAAoJEFNVTo/uthzA4ZoH/2I1UpAN1Uhbq3K52DfrAKX/
+xM4fpRiRkYqq+zLyx0tXqzxsso3uG7VhqAFrfwRBEokBxKBlbgC0VFuZc7NlAWU
1mIF5Nf/8BDYYSpkf9BTJMaYrva8IWpGRybuewNWa5KidT05u+o0dU5muBEGRHzw
Z/dsIuawexhUNz1CYH2bakY1kV+dtmIpO3wUBbOY1z/ICDJ6dFpZiWx2xIQ0FdJ2
kY5s+BnupevxAwU1cc77ThKZ4T6arqFMWpIcPIjt9PrgCF2jSwktYzLb3rmCh5V0
GLT4NK0g6+lHpHZyJkTchHeXZiVtL95VDn2FnohPiRjOhDrQTytzM2gzZD8oqlM=
=tvLN
-----END PGP SIGNATURE-----

--nextPart26170182.B3Nt93gHr5--

