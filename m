Return-Path: <greg@kroah.com>
Date: Tue, 6 Jul 2010 08:20:08 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100706152008.GB12566@kroah.com>
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<201007061504.09139.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <201007061504.09139.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Tue, Jul 06, 2010 at 03:04:07PM +0200, Sven Eckelmann wrote:
> Sven Eckelmann wrote:
> > Hi,
> >=20
> > here are patches targetted for 2.6.36. All patches needed for that patc=
hset
> > are already part of your staging-next tree.
> >=20
> > All patches are cleanup patches and no new feature is added.
> >=20
> > thanks,
> > 	Sven
> >=20
> > Antonio Quartulli (1):
> >       Staging: batman-adv: Convert names from Java to C style
> >=20
> > Linus L=FCssing (1):
> >       Staging: batman-adv: Avoid rounding issues for local hna timeout
> >=20
> > Marek Lindner (4):
> >       Staging: batman-adv: replace manual calculation by msecs_to_jiffi=
es()
> > for better readability
> >       Staging: batman-adv: Add sysfs abi documentation
> > about bonding
> >       Staging: batman-adv: adapting source version to revised
> > versioning scheme Staging: batman-adv: fix early debugfs deinitializati=
on
> >=20
> > Simon Wunderlich (1):
> >       Staging: batman-adv: Lower resolution for timeouts
> >=20
> > Sven Eckelmann (3):
> >       Staging: batman-adv: Add include guards to all header files
> >       Staging: batman-adv: Allow to build it inside the kernel
> >       Staging: batman-adv: Remove dependency to PROCFS
>=20
> Hi,
>=20
> we send you those 10 patches 10 days ago and they don't seem to be merged=
 in=20
> you staging-next tree. Linus has already released -rc4 after his vacation=
 and=20
> it is unclear to me how long it takes until 2.6.35 is released and I am n=
ot=20
> allowed to submit patches for 2.6.36.

It will be a few more weeks before .35 is released.  Please note that I
was working on 5 stable kernel updates last week plus an extended
holliday weekend here and then there's my "real job" that I also have to
do :)

I should get to your patches this week, don't worry, they will make it
into .36 with no problem.

> Do you think that I can still submit some patches to you for 2.6.36 or sh=
ould=20
> I wait for 2.6.37?

Please send them on, if they go on top of these, I have no problems
adding them.

thanks,

greg k-h
