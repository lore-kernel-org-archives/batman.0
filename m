Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 6 Dec 2011 18:36:45 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111206173645.GA17017@pandem0nium>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<20111206150134.GA12168@pandem0nium>
	<20111206152106.GJ10131@lunn.ch>
	<201112062330.54377.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <201112062330.54377.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there,

On Tue, Dec 06, 2011 at 11:30:54PM +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> > When it is in debugfs, it implies that the user has no choice, it is a
> > debug tool only. So when the development is finished, one day batman
> > will just swap from IV to V, and the user gets no choice?
> >=20
> > For the moment, i think it is O.K. in debugfs. However, there should
> > be some sort of idea how this is going to work when it comes to
> > actually mainstream use of V. Is it simply that IV is dead, you need
> > to use V now. Or do we give the user a choice and some file under /sys
> > to make this choice?
>=20
> the idea of using debugfs instead of sysfs was to avoid the chicken & egg=
=20
> problem (I guess). However, looking at my batman-adv debugfs entry tells =
me=20
> that we have the same problem there. Unless we want to move this file int=
o the=20
> debugfs batman-adv root folder (/sys/kernel/debug/batman_adv) we can't mo=
ve=20
> forward either. The whole init/config structure has been designed for "cr=
eate=20
> bat0 first".=20
>=20
> If we don't want to rewrite this whole part I only see 2 options:=20
>  * compile or module parameter
>  * changing the routing algo on the fly

Yeah, we would have to move it into /sys/kernel/debug/batman_adv in the roo=
t,
but Andrew may be right about future "non-debug" algorithm selection.

Maybe we go back to Antonios idea with the module parameter, but make it
changeable in runtime. Haven't done that yet, but it seems to be possible [=
1]:

''Loadable modules, after being loaded into the running kernel, also
reveal their parameters in /sys/module/${modulename}/parameters/. Some of t=
hese
parameters may be changed at runtime by the command
"echo -n ${value} > /sys/module/${modulename}/parameters/${parm}" ''

The rest would work as described: having a default value, allow user
changes in runtime and use the configured algorithm value for the next
soft interface creation.

How about this?
	Simon


[1] http://www.kernel.org/doc/Documentation/kernel-parameters.txt

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7eUq0ACgkQrzg/fFk7axamyACfXu8iCeEnWhNuWKI01pejUnIS
36IAnjPdAWfIrg0NiBS1gEHXNCx7F0GN
=N3W5
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
