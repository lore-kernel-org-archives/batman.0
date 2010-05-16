Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 16 May 2010 15:18:58 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100516131857.GA15848@pandem0nium>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005130119.39204.lindner_marek@yahoo.de>
	<20100512173830.GA27912@kroah.com>
	<201005122056.05476.sven.eckelmann@gmx.de>
	<20100513114507.GF4946@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20100513114507.GF4946@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv:
	convert	multiple /proc files to use sysfs
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


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

thank you very much for your suggetions. I'm currently sitting here
with Marek and Sven in Berlin and we were discussing your suggestions.
Our conclusion is:

 * We could write and read "enable/disable" only from the respective
   files (like aggregation). In this case we don't need the word=20
   "enabled" in the name however, as we already use it to set the=20
   status, so we would rather skip it.
 * we can rename aggregate_ogm to aggregate_ogms, i personally
   don't like CAPS in these names. ;)
 * We don't like the _msecs suggestion. It does not seem very common
   with other kernel driver configurations. We could not find any other
   files in batman-adv which are configured with a unit, so we would=20
   suggest to keep it like it is.
 * As you suggest, we should move the hints/verbose stuff from=20
   the module into batctl. There we could explain the possible commands,=20
   or also show the units. Then we would keep the sysfs "minimal".=20
   Also the "Usage" kernel change is a good idea imho.
 * The bonding and gateway features should be discussed at another time,
   i'll have some more changes in bonding soon, not sure about Marek
   gateway plans. These are 0.3 features and it does not hurt the maint=20
   version if we change these a little bit later.

best regards,
	Simon  =20

On Thu, May 13, 2010 at 01:45:07PM +0200, Andrew Lunn wrote:
> > The rest can be in sysfs?:
> >  * /sys/class/net/<iface>/batman-adv/mesh_iface
> >  * /sys/class/net/<iface>/batman-adv/iface_status
> >  * /sys/class/net/<mesh_iface>/mesh/aggregate_ogm
> >  * /sys/class/net/<mesh_iface>/mesh/orig_interval
> >  * /sys/class/net/<mesh_iface>/mesh/vis_mode
>=20
> As far as i can see, these are all single values. I would however
> suggest a few changes, to make it a bit clearer what the values are
> and what units are used.
>=20
> * /sys/class/net/<mesh_iface>/mesh/enable_aggregated_OGMs
> * /sys/class/net/<mesh_iface>/mesh/enable_vis_data
> * /sys/class/net/<mesh_iface>/mesh/orig_interval_msec
>=20
> "enable" suggests the control can be enabled/disabled. It gives the
> user a hint to try Boolean values: 0/1, true/false, enable/disable.
> Our current code accepts 0/1 and enable/disable, so the user has a
> good chance of guessing correct.
>=20
> enable_aggregated_OGMs is more grammatically correct. We are
> aggregating multiple OGMs into one big OGM packet.
>=20
> "_msec" gives the user the units to use for the orig_interval.
>=20
> I would also change the values read from the files. Currently it is
> not a simple value. It is a value, plus some text which batctl uses,
> or hints for the user when using cat/echo. eg:
>=20
>         return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1=
\n",
>                        aggr_status =3D=3D 0 ? "disabled" : "enabled");
>=20
> IMHO, we should just output 0/1, true/false/ enabled/disabled. I don't
> really care which, but is should be only a single word.
>=20
> For me, batctl parsing the hint the kernel returns does not make much
> sense. Once this kernel ABI is defined, it will never change,
> ever. Since it will never change, we can hard code the hint into
> batctl. That then brings the syfs files in line with the single value
> requirement.=20
>=20
> What we loose is the hint for people using cat/echo, not batctl. How
> big a problem is this? I don't think it is a big problem. When you cat
> the file you see "enabled", go guessing "disabled" is not too hard. We
> already return -EINVAL when in invalid value is tried and log a
> message to the kernel log. It would be easy to extend this kernel log
> message with: "Usage: enable | disable.
> For orig_interval_msec, i would extend the kernel log message with:=20
> "Usage: integer between %d  and %d", (JITTER * 2)+1, 0x00ffffff.
>=20
> That i think covers all the mainline configuration options. We have a
> few more in trunk. I would suggest a rename to be consistent:
>=20
> enable_bonding
>=20
> gateway is a bigger problem. I think it needs splitting up into a
> number of files, but i don't know the code well enough, and could not
> quickly find a good description of the options.
>=20
> 	Andrew
>=20
>=20
>=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvv8MEACgkQrzg/fFk7axYPmACgzjAMPcRxmNAv66DuZLMvSjPz
HisAoMmYbZ+MAHOlbs82R19Z1h6Knznx
=YSlB
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
