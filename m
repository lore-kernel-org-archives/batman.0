From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Visualization server
Date: Mon, 17 Nov 2008 10:44:53 +0100
References: <49626.149.5.32.200.1226911838.squirrel@www.rivertowermail.com>
In-Reply-To: <49626.149.5.32.200.1226911838.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1501869.HH1ezfcrU9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200811171044.56591.sven.eckelmann@gmx.de>
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

--nextPart1501869.HH1ezfcrU9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 17 November 2008 09:50:38 Derek C wrote:
> Hi all,
>
> Is there any links re: a batman visualization server?  (servers themselves
> and/or the visualization protocol format?)
Sry, but I don't understand what you want here. Ok, I will add informations=
=20
for the stuff in the parenthesis.

=46or downloads see https://dev.open-mesh.net/batman/wiki/Download

Specification does only exist in form of the source code.
The nodes will only send their current neighbors and quality informations t=
o=20
the vis server over udp (port 4307) The format of the packets is not really=
=20
complex.

The basic packet has a header which looks like that:
	address sender_ip; /* 4 bytes network byte order */
	guint8 version;    /* currently 23 */
	guint8 gw_class;   /* encoding:
       http://tools.ietf.org/html/draft-openmesh-b-a-t-m-a-n-00#section-7.1=
 */
	guint8 tq_max;     /* maximum transmission quality */

After the header are n data chunks which looks always like:
	guint8 type;  /* 1 - NEIGH; 2 - SEC_IF; HNA - 3 */
	guint8 data;  /* (type =3D=3D NEIGH) transmission quality between two nodes
	                 (type =3D=3D HNA) current netmask */
	address ip;   /* 4 bytes network byte order - address of the host which
                      link (sender_ip -> ip) is described here */

> I've seen a link to https://www.open-mesh.net/batman/vis but I've noticed
> that (generally) links to open-mesh.net seem to all give 404s.
Yes, the page was removed (only some screenshots on it and nobody created a=
=20
HTTP 301 Moved Permantly rewrite for it. Maybe somebody could add following=
 to=20
the .htaccess inside the folder for https://www.open-mesh.net/batman/ (or=20
configure the apache otherwise):
RewriteEngine On
RewriteRule .* https://dev.open-mesh.net/batman/ [R=3D301,L]

Take a look at=20
  http://web.archive.org/web/20080109231515/http://open-mesh.net/batman/vis
for the old page.

Best regards,
	Sven Eckelmann

--nextPart1501869.HH1ezfcrU9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkhPRUACgkQqQGwKVlMoDuMsQCfT/PfHn58RKEspWd7At617l5F
kLgAoNoQL6fe/g7wBHqDpA1alrT4/Q7M
=xuhc
-----END PGP SIGNATURE-----

--nextPart1501869.HH1ezfcrU9--
