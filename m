Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Aug 2009 22:23:06 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090830202306.GB2410@pandem0nium>
References: <20090830013647.GA26017@Linus-Debian>
	<20090830073752.GO16067@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20090830073752.GO16067@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output	in
	dot-file-format
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 30, 2009 at 09:37:52AM +0200, Andrew Lunn wrote:
> > Cheers, Linus
> >
> > PPS: I had to introduce a src-field in the vis-packet-struct,
> > therefore the compatibility version had to be increased as well.
>=20
> I'm thinking about linux-mainline here.
>=20
> Does it make sense to have a version number per message type? Some
> things we can do backward compatibility easily, some things not.
>=20
> I guess it should not be too hard to do backward compatibility
> here. If you receive a version 7 do the old way of getting the source
> address. If its a version 8 packet, use the new way?

Generally possible, but as we store the vis information locally=20
in whole packets we have to distinguish everywhere between the versions
(packet handling, proc access, etc). This will not make the code
look pretty.

>=20
> Allowing this sort of backward compatibility also makes deployment
> easier. You currently have a real danger of loosing contact to some of
> your nodes during software updates. If you do it in the wrong order,
> you could end up with a disconnected island.

Each software updates on meshed nodes is difficult. Even=20
if you just change the channel, the ESSID/BSSID or other wifi parameters
you can end up with islands. Most setup i have seen tried to use software
firmwares as homogenous as possible, even if they are a little bit older.
Software Updates in mesh networks always require more sophisticated
strategies.

>=20
> Also, once in mainline, the vis file becomes part of the well defined
> API. It should not just change in ways which are not backward
> compatible. I'm guessing this change breaks all my tools for parsing
> vis, and it probably breaks other peoples tools. Ideally, we strip out
> all graphviz and JSON formatting from the kernel and put it into
> userspace, eg batctl. Tools should then use batcl. It then becomes
> safer to change the proc vis format. The output of batctl stays the
> same, unless you add a command line flag to enable the new feature.

Mhm, even if we had transported the data from kernel to userspace, we
would have ended up in a change to this interface as the data format
changed (additional source field).=20

However i've added a compile flag in the reviewed version of linus patch
which should give you the possibility to get the "old" vis output.

Generally i think that the patch was really neccesary as the original
vis did not consider nodes with multiple interfaces. Disconnected graphs
were the result of this, which makes the vis output pretty useless
if you employ nodes with multiple interfaces. I think the approach
by using clusters is quite good too, even if we (the toolwriters,
me included) need to change their parsers now.=20

>=20
> This move to mainline requires some adaptations to the development
> ways. We need to discuss this and need to get the basics sorted out
> before we do go into mainline. However, it looks like we could be in
> mainline very quickly if we wanted.

I agree, we should sort this out early. My personal opinion is that
the algorithm will be optimized further, and it will make the code
unmaintainable to add exceptions for all older versions (especially
the various intermediate versions).

As it was pointed out earlier by Marek and Elektra, using multiple versions
in one network will most probably lead to "side effects". IMHO it's better
to let users know that it won't work properly backward than risking these
side effects.

Usually we have stable versions (e.g. batman-adv 0.1) with a specific forma=
t,
and an ongoing development in the svn trunk. Maybe we should do the same
for future kernel development - maintaining one packet and algorithm version
in the kernel, and further develop the algorithm on our own (e.g. in a=20
git tree or with sets of patches)?=20
In this case, we should post the current batman-adv to the list when
0.2 is stabilized and finished. Mainline algorithm should only be changed
when we reach a new stable version.

best regards,
	Simon

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqa36oACgkQrzg/fFk7axYixACfQpGrntYJyIRofGKega1ugD9r
COgAn2YJeB8bOXIQKcg//UKXq+AodDFj
=/0F6
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
