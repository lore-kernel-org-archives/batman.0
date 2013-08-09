Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 9 Aug 2013 10:04:39 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130809080439.GA15777@pandem0nium>
References: <000001ce94ce$abf72e00$03e58a00$@griffithuni.edu.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <000001ce94ce$abf72e00$03e58a00$@griffithuni.edu.au>
Subject: Re: [B.A.T.M.A.N.] Alfred,
 Unix connections randomly refusing a connection
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Fri, Aug 09, 2013 at 05:04:17PM +1000, Joshua Head wrote:
> Hey,
>=20
> Just querying for some information on the best way to debug  Alfred.=20
> It's currently at random points in time, independent of each node refusing
> to connect to a Linux socket. We have 4 nodes and the refusal is only
> localised that particular node.=20
> Restarting Alfred helps. But it's not a long term solution. We are very
> interested in Alfred. It solves a lot of our problems with our scripts.
> Basically if you have any direction for debugging it, or need any dumps.=
=20
> Feel free to ask.=20
> As far as I'm aware the Alfred is working, it's updating our test script.
> Just randomly stops accepting connections.
thanks for your bug report. You say alfred refuses unix connections randoml=
y,
can you be more specific when this happens? Alfred runs as a daemon, and the
general way to start is to run alfred in client mode (-s or -r) to talk to
the alfred server via unix socket.

So I'd like to know:
 * is it the client instance which refuses the connection? if yes, can you
   please post what you call + output message?
 * is the alfred server is still running, or does it crash at some point?
 * what operating system and alfred version are you using?
 * do you get any message (e.g. syslog) from the alfred server?
 * you could run alfred as server manually instead of some init scripts to
   check if it crashes and throws any messages
 * also, if possible you could create dump and provide it with your binary
   if the error message is not verbose (or it crashes with a sigsegv or som=
ething)

Thanks,
	Simon

>=20
> Thanks,=20
> Joshua Head
>=20

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIEopcACgkQrzg/fFk7axbigQCeKQ+lnd7TBNKw3UzQCtQc+Lfm
K9wAnjRn859/AFwDF0q7k04hKlg/y6r9
=HN2S
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
