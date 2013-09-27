Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 27 Sep 2013 14:07:51 +0800
Message-ID: <1412297.LnmMWnToDl@diderot>
In-Reply-To: <0b55d834953625e28eb8c77b96c08cc0f13448dd.1380184164.git.mschiffer@universe-factory.net>
References: <de510a1e7cb175c854734fa07c347f18ac697446.1380181735.git.mschiffer@universe-factory.net>
 <0b55d834953625e28eb8c77b96c08cc0f13448dd.1380184164.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1525655.2yB53aTCca";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: set network coding
	packet handlers in batadv_recv_handler_init()
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1525655.2yB53aTCca
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 26 September 2013 10:29:49 Matthias Schiffer wrote:
> batman-adv saves its table of packet handlers as a global state, so handlers
> must be set up only once (and setting them up a second time will fail).
> 
> The recently-added network coding support tries to set up its handler each
> time a new softif is registered, which obviously fails when more that one
> softif is used (and in consequence, the softif creation fails).
> 
> Fix this by moving the handler setup to batadv_recv_handler_init(), which is
> called by batman-adv's __init function (and where most other packet
> handlers are set up).

Would you mind changing your approach to adding a global nc_init() / nc_free() 
and do the callback registration there ?

Thanks,
Marek

--nextPart1525655.2yB53aTCca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSRSC/AAoJEFNVTo/uthzA8Y8H/itmsqceX3HiBBIm3Dggdry1
/MgvXh2s268TSSTT/zsbUCzaVSqXevJUneM2q32tu7RWBxliyqMTsFKYf5VYhhf5
t6a13y3m5lQr8tg4uyEXTYN5uZSwQY9pni57h5mkmLTn73Pt/rvxI1k240FoOq0V
ApcsBe29onIorxUUrHVzxfKd133oJZ9Tqf0Bg6QYJlgIsy+vTZf8Z9GJcJ2IsCvb
JLEGdkMZx6mzz8xEQc9T38ugJK67P462aQGk6zPToPQ8/jzAa0Y7bZkEKWfygv5c
dpQKpsKXm2Cpr9lFoRenuTEpO3UBvLITBjbxo0u3fAmrGQLHAdTXKHkkHjk50ns=
=8sV5
-----END PGP SIGNATURE-----

--nextPart1525655.2yB53aTCca--

