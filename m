Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2016 11:25:42 +0200
Message-ID: <1919523.EiXNAC6LDj@bentobox>
In-Reply-To: <12399409.fEQLp0ttQ1@bentobox>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
 <20160509190608.GA18522@lunn.ch> <12399409.fEQLp0ttQ1@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2706275.yEzUM0M43v";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 00/12] netns and netlink support
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

--nextPart2706275.yEzUM0M43v
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday 10 May 2016 09:00:49 Sven Eckelmann wrote:
> On Monday 09 May 2016 21:06:08 Andrew Lunn wrote:
> > > I hope this helps to reduce the conflicts (even when not resolvin=
g it
> > > completely) between the tp_meter and the netlink patchset.
> >=20
> > Hi Sven
> >=20
> > Do you want to take over my patches and merge them all into one set=
?
>=20
> No, this is the last thing I want to do :)
>=20
> I only want to get the "big" conflicts solved and mark the parts whic=
h most
> likely will needs to be changed before Marek will accept them.
>=20
> I will have not much time in the next days to do any private work on =
it. So it
> most likely not the best idea to give me the patchset with a lot of T=
ODOs in
> it ;)
>=20
> I will try to poke Antonio and Marek some more so we get a common sta=
rting=20
> point (the two patches from batctl/batman-adv) which we then can use =
prepare=20
> our patchsets with a lot less conflicts.

Some reports which I forgot to mention yesterday and which I've just re=
membered:


bracket_align master ./net/batman-adv/bat_iv_ogm.c
=2D-------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bat_iv_ogm.c:2371, was 37=
 but expected 61
    Found wrong alignment at ./net/batman-adv/bat_iv_ogm.c:2372, was 37=
 but expected 61


checkpatch master ./net/batman-adv/bat_v.c
=2D-----------------------------------------

    CHECK: Please don't use multiple blank lines
    #450: FILE: ./net/batman-adv/bat_v.c:450:
    +
    +
   =20
    total: 0 errors, 0 warnings, 1 checks, 732 lines checked

Kind regards,
=09Sven
--nextPart2706275.yEzUM0M43v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMakWAAoJEF2HCgfBJntG5nsP/2D4/jIaNz+2b1Hti/9oVDTM
JC51yCmHAhO8G8SXtHvlxJ9gDarvNzmRx517BkgiR3xBAJ1hNZek20HztMEL3I+k
b1bGLHXrsn9VUG2vNNbKcEmSyGgoD/44XqatH59f5vCrMqDPYmKl/mcUa4mo02LD
ZpbTCUhFgRJef9/QZKUunMCdqWuhIzBbJOfusnQWxKFm4z8D7a81CvcGCNcdE+K2
cvWA8M1QYlxXEBQ7xgxjFZLncCkhqPJm06W8kSyqb2RwS1N4ajIeb+pmvDrhwQg5
COS2d2QCr6UXNct1TaHgEk9KUsd3WXvTIo5Xslo2CM8IJZ4unbuXEft8RvVLnl+J
LMH/wA5mhZx5FnL0yEvTKlNVObbVEWxN1QcOvppTrFi+fQ3dSWvfUd9tW1I4xkF9
8hhCadSQernD7VofUlLtBtcrMzDUon37mP3CLFl1Gr/8CmfIXXid6rdEHb1rT2sp
RcUO7xu7GuVghRmZfyAcTOGCm9wONZUayMwCVu+6sUGPKVl+Qh+QLcPawWqw5Nmq
I76zkhZK9LYSl0TWwTX9vjH4vPN3OombvF+ZLMZcsUWU1jnhv0x7l2klwp7gWEj1
0SiEfnNKkSta2o0ZsQxrnl1kOJke5fR1MzZLF/iBushO1pHpMzvjSlQHJGsHIfrL
3yV9RI2dcQ+FnC47mlZg
=+GH7
-----END PGP SIGNATURE-----

--nextPart2706275.yEzUM0M43v--

