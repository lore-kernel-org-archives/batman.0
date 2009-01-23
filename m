From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 23 Jan 2009 11:09:24 +0100
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<200901211621.21753.sven.eckelmann@gmx.de>
	<278AF6CA06F13D4C9E9F69C7B9AB3B8303504623@MBX21.stu.nus.edu.sg>
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504623@MBX21.stu.nus.edu.sg>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5141447.jiH7Ka4Gqj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901231109.27846.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Install Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--nextPart5141447.jiH7Ka4Gqj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 23 January 2009 10:30:26 Kartik Muralidharan wrote:
> I was able to compile and checking 'file batmand' gave me the output
> mentioned below.
>
> But running ./batmand ath0 gives me an error.
What error? Is it a dynamic linker error? Does `./batmand` gives the same=20
error? Does `dmesg|tail` gives more information about that problem?

> What configuration do I need to do on the wireless interface on the
> device?
Their are many configurations possible, but I will try to explain a common=
=20
one:
=2D Get the device in adhoc mode (for example create a vap in adhoc mode wi=
th=20
madwifis wlanconfig)
=2D set the essid
=2D set the cellid
=2D set the channel/frequency
=2D start the device
=2D set a unique ip to the device

$ wlanconfig ath0 create wlandev wifi0 wlanmode adhoc
$ iwconfig ath0 essid testnet
$ iwconfig ath0 ap 02:00:de:ad:be:ef
$ iwconfig ath0 channel 10
$ ifconfig ath0 $IP
$ ip a add $IP brd $BRDCAST dev ath0
$ ip link set ath0 up

I hope that I didn't forgot anything.

Regards,
	Sven

--nextPart5141447.jiH7Ka4Gqj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl5l1UACgkQqQGwKVlMoDupyQCgkbaksepMMVqGeaXS7CeOIaU/
j90AoLypAulC6BsKainIriZ9vibHpdEq
=KIuz
-----END PGP SIGNATURE-----

--nextPart5141447.jiH7Ka4Gqj--
