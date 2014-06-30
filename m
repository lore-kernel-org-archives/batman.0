Return-Path: <christof.schulze@gmx.net>
From: Christof Schulze <christof.schulze@gmx.net>
Date: Tue, 01 Jul 2014 00:07:32 +0200
Message-ID: <1543341.WcWe2c7VXj@lappi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7153070.bGlMtC4xKc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Fwd: Re:  increasing BATADV_FRAG_MAX_FRAGMENTS
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart7153070.bGlMtC4xKc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Dirk is not on this list, so I am forwarding the information of ihs
experiment.

=2D---------  Forwarded Message  ----------
Hi, Marek!

Please forward this as appropriate.

Am 30.06.2014 um 08:08 schrieb Marek Lindner <mareklindner@neomailbox.c=
h>:
> > During an experiment it was found, that
> > BATADV_FRAG_MAX_FRAGMENTS=3D16 allows ~72 clients to be connected t=
o
> > one single access point.
> would you mind sharing some details regarding the experiments you
> performed ?  The reason for this question is that there is no 72
> client limit we know of (unless fragmentation was disabled).

I put a freifunk router with batman.adv in a room with 300 conference=20=

participants (with about 2 WLAN clients p.p.) as an emergency network a=
ccess=20
means for a failing venue network.

The batman client statistic showed a very untypical hard clip at 72/74 =
batman=20
clients and new wlan clients seem to time-out without any network traff=
ic like=20
this:

Thu Jun 26 15:33:44 2014 kern.warn kernel: [15577.090000] net_ratelimit=
: 1121=20
callbacks suppressed
At the same time, I'm seeing a lot of these:
Thu Jun 26 15:31:54 2014 daemon.info hostapd: wlan0-1: STA b4:f0:ab:9b:=
b0:94=20
IEEE 802.11: associated (aid 7)
Thu Jun 26 15:32:54 2014 daemon.info hostapd: wlan0-1: STA b4:f0:ab:9b:=
b0:94=20
IEEE 802.11: disassociated
Thu Jun 26 15:32:55 2014 daemon.info hostapd: wlan0-1: STA b4:f0:ab:9b:=
b0:94=20
IEEE 802.11: deauthenticated due to inactivity (timer DEAUTH/REMOVE)
=20



There is no hostapd client limit configured and otherwise (as I underst=
and it),=20
clients would be have been rejected and not time-out without access to =
the=20
DHCP-Server (only accessible via batman).

Unfortunately, that setup is no longer available for more testing.

Any ideas?

Dirk

=2D-=20
()  ascii ribbon campaign - against html e-mail
/\  against proprietary attachments

--nextPart7153070.bGlMtC4xKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlOx36UACgkQpZfyPAmdZJnOeACggS1jqWOLJv0kUd2fxoXk4S7g
fl4AnRLn1DXVLlC/3Ld2YyS0hC05QhRa
=HsjV
-----END PGP SIGNATURE-----

--nextPart7153070.bGlMtC4xKc--

