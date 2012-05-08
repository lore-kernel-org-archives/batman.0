Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FA916EB.8030609@universe-factory.net>
Date: Tue, 08 May 2012 14:51:55 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA54C09.6000303@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
	<4FA7AD9B.2030604@universe-factory.net>
	<201205081404.14409.lindner_marek@yahoo.de>
In-Reply-To: <201205081404.14409.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7DB3DBF8A7029A27E43A5916"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
 without neighbors on the primary interface
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7DB3DBF8A7029A27E43A5916
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 08:04 AM, Marek Lindner wrote:
> On Monday, May 07, 2012 19:10:19 Matthias Schiffer wrote:
>> On 05/07/2012 08:40 AM, Marek Lindner wrote:
>>> If you wish to replace the mac addresses with readable name you can
>>> simply use a bat-hosts file to tell batctl which mac address should b=
e
>>> replaced. Check the bat-hosts section in our batctl online manpage:
>>> http://downloads.open-mesh.org/batman/manpages/batctl.8.html
>>
>> I know about bat-hosts, but this only works when the host displaying t=
he
>> data knows all the MAC address/hostname mappings. For community meshs
>> like Freifunk networks it would be much nicer to allow each host to
>> supply its own hostname for vis in my opinion. I think one possibility=

>> to add this without breaking compatiblity would be adding a hostname
>> record after the neighbor entries in the vis packets.
>=20
> Flooding the network with arbitrary data like hostnames, service=20
> announcements, weather info, etc comes up from time to time but it ofte=
n boils=20
> down to the question: Why does it have to be in the kernel ? There are =
several=20
> ways to implement this feature in user space today without changing the=
 kernel=20
> code.
>=20
> Regards,
> Marek

I see your point, but then one could also ask why the visualization has
to be in the kernel at all...

Matthias


--------------enig7DB3DBF8A7029A27E43A5916
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pFuwACgkQq3qIxbiQM9h11ACgiPhOtd7URwo0Peiu74S17FY4
F6sAn2X7mBZW/8ERZumUcbn2Pe9qWdQD
=JxXM
-----END PGP SIGNATURE-----

--------------enig7DB3DBF8A7029A27E43A5916--
