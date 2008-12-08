Date: Mon, 8 Dec 2008 18:27:15 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Looking for batman-adv 0.1-alpha
Message-ID: <20081208172715.GA20190@pandem0nium>
References: <4938F21D.2050907@irt.de> <20081205200414.GB27271@pandem0nium>
	<493CDAD8.10400@irt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <493CDAD8.10400@irt.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tobias,

On Mon, Dec 08, 2008 at 09:29:12AM +0100, Tobias Gieseke wrote:
> and thanks for the helpfull informations so far. As there is a command=20
> "batmand-adv" available on the meshnode i assume they use the userspace=
=20
> version of batman-adv (correct??). Can i copy the executeable file from=
=20
> the meshnode to my desktop an run it??

Yep, that's the userspace version. And yes, you can copy it to your
desktop. It should [tm] work. ;)

> I'd really like to use the current version of the kernelland but i loose=
=20
> the warranty of the meshnodes if i make any changes on the command shell=
=20
> via ssh or serial port :-( I will think about that when i've finished my=
=20
> tests ;-)

Mhm, no idea if you can backup the whole system image or something, and
re-flash it after your experiments, but that would probably void the
guarantee as well ... ;D

> Sorry, but my question to open-wrt was not precise enough. I wanted to=20
> know if there is a chance to get batmand-adv running on open-wrt with=20
> broadcom wifi. AFAIK batmand-adv is only running on kernel 2.6 but with=
=20
> kernel 2.6 broadcom wifi is not running on open-wrt (according to the=20
> open-wrt homepage).  Maybe you know a trick to get batmand-adv running=20
> on the Linksys WRT54GL or the Buffalo WHR-HP-G54 WiFi-Router, with WiFi=
=20
> running of course.

Well, you can also use batman-adv userland on the Broadcom, that should
work fine. "Kernel 2.6 doesn't work (properly) on broadcom/openwrt" is the =
same=20
info i have, no idea if this has changed ... :(

best regards
	Simon

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJPVjzrzg/fFk7axYRAkDmAJ9RjKfMEOd70Y3KpTeXfUkSdghF0ACgr5eR
uzAhdGVJJQTMyYv90SR/Eq0=
=spH6
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
