Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 04 Aug 2015 03:52:32 +0800
Message-ID: <1875026.jQU1SXUeop@voltaire>
In-Reply-To: <3944293.0zRb5b9TWb@prime>
References: <1437856635-27068-1-git-send-email-mareklindner@neomailbox.ch>
 <3944293.0zRb5b9TWb@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9488187.XJeIif3QZe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move hardif refcount inc to
	batadv_neigh_node_new()
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


--nextPart9488187.XJeIif3QZe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, August 03, 2015 20:01:30 Simon Wunderlich wrote:
> On Sunday 26 July 2015 04:37:15 Marek Lindner wrote:
> > The batadv_neigh_node cleanup function 'batadv_neigh_node_free_rcu()'
> > takes care of reducing the hardif refcounter, hence it's only logical
> > to assume the creating function of that same object
> > 'batadv_neigh_node_new()' takes care of increasing the same refcounter.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Applied in revision 02cf80c.

Regards,
Marek

--nextPart9488187.XJeIif3QZe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVv8aEAAoJEFNVTo/uthzAIw4H/jffAbE5V8pmPTMjWZSiso/+
uRqfwV1jhL/mNk7ld4xglog981JD0pEfQf4IH9kpodpOXVRuR6D2vZWzbNKOZ3vQ
6euLJqUti931s73h/SnTxIoDI5PMzJV63NP7y7sN6V+Ui1BkyBYXLpxAS2KHCv7P
SEGh7t24QKK5u9dX7JoL3eqXCU0geKr1U4S83chnAGUrfHNcM+N9/rGCS1iZWplC
Dq6A9thsS/ut5k7gTBP5S+JX3Uj2NT4oxa3QJagk4QJoUgRrNEEwpz0v2+TI160s
XYxagSH2SzTBWI780Dtr83mXAJ8D8pT6EYTKr46ssvKhBDtXiWonFyIW1L6Zp6U=
=tsYj
-----END PGP SIGNATURE-----

--nextPart9488187.XJeIif3QZe--

