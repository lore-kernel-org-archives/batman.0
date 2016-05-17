Return-Path: <a@unstable.cc>
Date: Tue, 17 May 2016 17:59:11 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160517095911.GF12056@prodigo.lan>
References: <1463087478-7101-1-git-send-email-a@unstable.cc>
 <2942703.MT5BSIy3gc@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <2942703.MT5BSIy3gc@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N. V -
 implement hard-iface init function
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2016 at 05:06:24PM +0800, Marek Lindner wrote:
> make[4]: *** [/home/marek/batman-adv/net/batman-adv/bat_v.o] Error 1
> /usr/src/linux-headers-4.4.0-1-common/Makefile:1401: recipe for target '_=
module_/home/marek/batman-adv/net/batman-adv' failed
> make[3]: *** [_module_/home/marek/batman-adv/net/batman-adv] Error 2
> Makefile:146: recipe for target 'sub-make' failed
> make[2]: *** [sub-make] Error 2
> Makefile:8: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-4.4.0-1-amd64'
> Makefile:72: recipe for target 'all' failed
> make: *** [all] Error 2


Sorry, but I should have not separated this patch from the other (that was
introducing the include line in bat_algo.h).

Now this patch depends on Sven's patchset.

I can rebase and resend it once Sven's patches have been merged.


Cheers,


--=20
Antonio Quartulli

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXOutvAAoJEJ4aZjxxc6bKeDQQAIoPkUaNY7HhS3a2ZPVAT7lC
DLTIslRjb/O6NStNzqsUQVFuCN40LewHxYwWKjDyyxnrLa9U+Qcji1tiz2sLMpcF
mk3z9mF4A1d5NiLkX1gX470JiSa1LQhkR6hSMbIE4/Eqi0MOfXuJTe1mwfNLULAh
QWGoGo8cQpWZ43+TZl6ceAcIJSo/VHzpVhcEmSUQ5wPVTUEpN7UNhNsHCPqf4lZn
kda42h20IUal3jxrbyEpLQJsXACYPvpmD8L9xUxxyzxktHSpRGClpIjAmjW327/S
G2pBJ+R4KmH/moxSuBYPip8bPQ8nBX+PQ4ZY9orQeuLI57XWs5IywR5e7XjkG3xm
0scDTdaq1OM3r8ldvAp92Ef/phi/RXmRw5xgqgYMms6loemUu+FNEUPL9mQf73eZ
G3hnGE+pe24nFXaUwEWd5c5Ra4p5WZ0PwV3aLKLlkfyPunUyiYvitsh6PQGlgOZU
EO+HXRLbQ5kNf75w+MjCh5fr8O2sQVLBp9JSVv386YQ6xbUPabbZikhSG6wtPPPo
laEvW/Pcx6obS9bSXUSjK2K2wjB8w/XtSUbS/R8GfGQigop8+AOAf2ctz8eKJ92A
mKq28KdtYAmvWYqHLkTpS+dF86H2MxLhufhM6/3AWguheq3DatLwqh0A/3/UCycl
ZdACPZf2Y246lY8AsCZV
=O8xa
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
