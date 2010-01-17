Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 17 Jan 2010 21:23:01 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100117202301.GB8696@pandem0nium>
References: <EACB115D0487C4459885C4B54EE8D9CF05D74AAB@USDALSMBS02.ad3.ad.alcatel.com>
	<201001170040.31071.sven.eckelmann@gmx.de>
	<EACB115D0487C4459885C4B54EE8D9CF05D74AAD@USDALSMBS02.ad3.ad.alcatel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <EACB115D0487C4459885C4B54EE8D9CF05D74AAD@USDALSMBS02.ad3.ad.alcatel.com>
Subject: Re: [B.A.T.M.A.N.] Security on adhoc network
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


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jaideep,

as Sven mentioned correctly, using the WPA sequence numbers in WPA_NONE
should be ignored. Some drivers (like madwifi) have to be teached to do
that. Sequence numbers do not make much sense in Ad-Hoc anyway, as there=20
is no central management for these sequence numbers. Of course, you lack=20
some security features like detecting replay attacks or changing session=20
keys which you have in master/station WPA.

best regards,
	Simon

On Sat, Jan 16, 2010 at 06:06:55PM -0600, LAMBA Jaideep wrote:
> Sven,
>=20
> I tried WPA_NONE and CCMP with wpa_supplicant on both the sides with
> preshared keys. By doing this you are right nobody can see the data and
> I get encryption and authentication. But here comes a twist.
> Lets say I power off one node completely after initial secure session.
> When he comes up wpa_supplicant starts off with 0 as sequence number. On
> the other node sequence number might be greater (or way greater) which
> causes other node to believe that he is experiencing a MIC_FAILURE
> attack.=20
>=20
> Based on my understanding drivers are needed to sync up TSF in adhoc
> networks which will eventually setup the right key and hence establish
> the session back. But that's isnt available now.=20
>=20
> So do we have any layer 2 security on adhoc networks that are currently
> being deployed.
>=20
> Thanks,
> Jaideep
>=20
> >> Are there any solutions currently under implementation for providing=
=20
> >> security (other than open/wep) over adhoc networks ?
> >
> >What kind of security do you need? Security is a big field. Maybe you
> just mean encryption and authentication.....
> >
> >When you only want to make the whole wlan stuff unreadable for the
> outside, you could just use WPA_NONE. But this doesn't resolve the
> problem that the key could leak and make the mesh >attackable - but that
> is something which could always happen. So it is probably not a solution
> for freifunk projects, but for mesh networks controlled by a company.
> >
> >There are other ideas for traffic over batman-adv. Just forget about
> encrypting your data over wifi, but instead do everything some layers
> above it. I think Linus had some ideas in implementing the >needed
> authentication and encryption over IPsec in a mesh. I am not sure what
> his ideas were exactly, but maybe he could add some more information
> about that.
> >
> >And most of the encryption and authentication stuff has to be resolved
> by the user and not by the network provider. This means https for
> sensible data instead of http, ssh instead of telnet, pop3s >instead of
> pop3 and so on.
> >
> >So it really depends what you want and cannot be resolved in a
> "security for everything, against any attack and for every purpose"
> blob.
> >
> >Best regards,
> >	Sven
>=20

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktTcaUACgkQrzg/fFk7axY48wCg2JIxWc7qHSO4f7IzQj16JAGz
BC0An3XyIkwimsTC/xMxgR8zoVkqOrRu
=cIYz
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
