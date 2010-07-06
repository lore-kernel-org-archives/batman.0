Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 7 Jul 2010 00:21:38 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007062346.43276.clemens-john@gmx.de>
	<201007070006.51804.lindner_marek@yahoo.de>
In-Reply-To: <201007070006.51804.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12414484.BEo4HpTX70";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007070021.43888.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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

--nextPart12414484.BEo4HpTX70
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you a lot for you answers!

I still got two question left that I remembered when I read your answers:
We discussed our networksetup on IRC (you remember?) and we decided to choo=
se=20
the setup with tinc an not sending batman advanced packages over VPN.

Now batman advanced nodes behind the VPN does not get listet in the origina=
tor=20
tables of nodes on the other side of the VPN.
But do they get listed on the gateway list? Can Batman advanced choose a=20
gateway behind the VPN?

I can not test this at the moment so I have to ask.

Last one: Is it right that the trunk version of batman advanced is not=20
compatible with Batman advanced 0.2.1? Is trunk compatible with 2010.0.0?

Thank you
Clemens

Am Mittwoch 07 Juli 2010, 00:06:51 schrieb Marek Lindner:
> On Tuesday, July 06, 2010 23:46:36 Clemens John wrote:
> > Okay I did this but I have some questions left:
> No problem.  :)
>=20
> > Does the DHCP server on the gateway need to distribute IP-Adresses?
>=20
> The server should distribute IP addresses and a default route to itself.
> I'm not sure whether you will find a dhcp server which does not distribute
> IPs but default routes.
>=20
> > If so I think they have to be distributet on the batman interface right?
>=20
> Correct.
>=20
> > Does the Batman advanced interface on the clients need to request an
> > IP-Adress from the DHCP server or can I also set a static IP adress?
>=20
> That depends on your needs. Any interface which is supposed to use the
> gateway feature has to run a dhcp client. If the batX interface on the
> client does not need it you can give it a static address. If you just want
> to define the IP address of a specific host you can also work with aliases
> / multiple IPs per interface.
>=20
> > If the clients need to request an IP adress from the DHCP server, where
> > is the difference between requesting an IP without Batman advanced and
> > with Batman advanced? Does Batman advanced say from wich server to
> > request the IP or which default route to choose?
>=20
> Normal dhcp requests are broadcasted through the entire network. Every dh=
cp
> server that receives this request will answer. If the client receives
> multiple answers it depends on the implementation to choose its "favorite"
> dhcp server. Most clients simply use the first server that answered.
> If you enable the gateway client this request will not be broadcasted but
> directly sent to the chosen gateway. The other dhcp servers will not
> receive this dhcp request.
>=20
> > Sry for this question we just discussed this on the last community
> > meeting and somebody wondered if this is the most beautiful way. Maybe
> > it=B4s not but you are right there is no other way.
>=20
> We had this layer2/layer3 discussion quite often and this is the compromi=
se
> we managed to achieve. It only works when enabled and indirectly via dhcp.
> It is not "beautiful" but it works.  :)
>=20
> > Okay but it will likely be usable without crashing right?
>=20
> No, it should not crash. I'm using it on a daily basis without problems.
>=20
> > How can I configure batman advanced in /etc/config/batman-adv to enable
> > gw server/client mode?
>=20
> Since it was not part of an official release it also is not supported by
> the uci scripts. You would have add it yourself.
>=20
> Regards,
> Marek

--nextPart12414484.BEo4HpTX70
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwzrHMACgkQZgdHbA22lqNjAACfbbTqHCFgKuj5jhM8mHNhnxrG
aDkAn3XA0lU+RJKxPX+S6bSkc1DRYrWg
=lrVg
-----END PGP SIGNATURE-----

--nextPart12414484.BEo4HpTX70--
