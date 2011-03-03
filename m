Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 3 Mar 2011 21:22:20 +0100
References: <1299179342-15418-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299179342-15418-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5622471.PH3Zv39De2";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201103032122.21671.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Null pointer dereference, ticket #146
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?iso-8859-1?q?L=FCssing?= <linus.luessing@ascom.ch>

--nextPart5622471.PH3Zv39De2
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> Hi everyone,
>=20
> By accident I've typed in a mesh interface name for batman-adv which
> already existed as a real interface. This produces a null pointer
> dereference in orig_hash_add_if():
> http://www.open-mesh.org/ticket/146
>=20
> The attached patch shall illustrate the problem, but I'm not quite
> satisfied with it. Although it seems to "fix" the problem and gets
> rid of the call trace, it is probably still very racy. Does anyone
> have an idea for a more sane but equally easy check to fix the issue?
> Or is the only sane solution to hold an rcu-lock and compare the
> hard_iface->soft_iface in hardif_enable_interface() with every
> hard-iface->net_dev from the hardif_list?
>=20
> Cheers, Linus

Oh, it doesn't fix anything - it just works by accident. :)
You are just happy that bat_priv->orig_hash is still memory that is accessi=
ble=20
by us and is zero.

Let me suggest another patch (may take a while).

Best regards,
	Sven

--nextPart5622471.PH3Zv39De2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNb/h8AAoJEF2HCgfBJntGgKEP/0DVI3X+sqbWgCMfTUyberY0
zpEb1i6BgYnybkkVHKnOiJdcTmigLNYYPz3CffDUmy2PZsZbXyBW2WqfoYnYpEyv
bArJXkD1HDJSsbsIMnoqJ3NekYsQQd7+8oG+zCusLI5qjixx0YXlrHEPV4Hq/wce
1oTzN26MRx+fVpdCVmX4E6c9spSGcY+EmcoGDaablNLLHmPYtbVdJtx3OaP/jMz0
jlU/XG9kBA1YQh9FhcdSSeqULvhrUk0dTTZa9pMMjUuMpyahYHyXNNG5iqViBeLy
VaWRLlADK5Kdo+RZF+gpuqAONRAEo/4dEAuqSlxytvrgnC5NC4fbTUXrMCyLPQ2R
/oNAlbvZIz4dbBLUW5H0d5HRCh/y80jDW6OmNh0yQLcfHESX3OHlqvRdMgPeWwRi
GCRbAwtL8t/mwRnRnC4ditz6sXu7ikRsETTt3oD+2ZYAc2XH13ojD4eXQ5mD0TMQ
uC6qT0l6Hy5+NSIMqKGx/nK74/6r7j/LqhS0YNOmPSji5FeL4ve8xBKJlBbJhDbE
T9sGW+NeB72wUniMCKEclOwlRx8p5F1Ui7+YjLSJXHFVV9Pk3wTBFnZPvci1JkLu
8iSOi094FiK1+Hb/GppN4yM4QaX9TH+Sxx0pE5fiyHZh0IM9vckVQ6DeJz97B+DS
GFOq/ZjwebeZh+04TiP9
=Hx3A
-----END PGP SIGNATURE-----

--nextPart5622471.PH3Zv39De2--
