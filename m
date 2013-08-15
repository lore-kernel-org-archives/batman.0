Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 15 Aug 2013 14:23:50 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130815122350.GA1588@pandem0nium>
References: <1375113404-10811-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <loom.20130815T031451-708@post.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <loom.20130815T031451-708@post.gmane.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH-next] batman-adv: set skb priority
 according?to content
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


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ammar,

On Thu, Aug 15, 2013 at 01:25:36AM +0000, Ammar Anuar wrote:
> Hi Simon,
> Thank  you for your patch. I really appreciate your great work. I setup t=
wo=20
> nodes connecting each other using batman-adv. After applying this patch, =
I=20
> tried to use iptables to change the DSCP value and it properly mapped wit=
h=20
> access category. But the when I put batman interface (bat0) under bridge=
=20
> (br0), DSCP value no longer mapped with access category. The iptables=20
> command that I used is
> iptables -t mangle -A POSTROUTING -s <source ip> -j DSCP --set-dscp <dscp=
=20
> value>
> I'm still new in this field. Did I miss some command to pass the iptables=
=20
> command to the bridge?=20

When you say "put under bridge", where are the packets generated? Do you ge=
nerate
the packets on the nodes on which batman-adv runs, or are you receiving/for=
warding
packets from other interfaces (eth0, wlan0...)?

In this case, the iptables rules might not apply correctly - you can check =
by
snooping the traffic on bat0 (using tcpdump/wireshark) and see if the DSCP =
field
is set according to your rules. If not, the iptables call might not be effe=
ctive
and you might want to check bridge-nf-call parameters (see the top of [1] f=
or
explanation).

If the DSCP field is set correctly but batman-adv still ignores it, please =
let me
know. :)

Cheers,
	Simon

[1] http://wiki.openwrt.org/doc/howto/netfilter
>=20
>=20
>=20

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIMyFYACgkQrzg/fFk7axbvXwCeN26UwZ2gheFQ3BIStz678cUR
hxEAoK7yDj3U5dcuj3A/mX6Nhaah8Dfk
=4HNa
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
