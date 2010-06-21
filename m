Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 21 Jun 2010 16:24:28 +0200
References: <201006211611.45412.clemens-john@gmx.de>
In-Reply-To: <201006211611.45412.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201006211624.28747.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Cannot build actual OpenWrt Backfire branch with
	Batman Advanced
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


Hi,

> Checking out files from the svn repository...
> svn: Write error: Broken pipe
> svn: '/svn/batman/!svn/bc/1718/branches/batctl-0.2.x' path not found
> svn: '/svn/batman/!svn/bc/1718/branches/batctl-0.2.x' path not found
> make[3]: *** [/home/floh1111/openwrtbuild_luci/dl/batctl-maint-1611.tar.g=
z]

hmm.., we recently moved the the batctl-0.2.x branch into the git repositor=
y=20
but retrieving an older version should be no problem. Not sure what is goin=
g=20
wrong here.


> Can someone fix this please?
>=20
> What=B4s up with the latest release (Batman-adv 2010.0.0)?
> Will I be able to build it with the Backfire branch? Maybe someone can
> update the makefile?

It will be build with backfire, I have no doubt about that. Updating the=20
Makefile is on our todo list but it will take a couple of days. Nico (from =
the=20
OpenWRT team) is helping us to reorganize & simplify the Makefile. We will=
=20
probably have it by the end of the week but help is always welcome.  :)

Regards,
Marek
