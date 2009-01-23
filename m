From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 23 Jan 2009 01:26:18 +0100
References: <200901212136.01338.sven.eckelmann@gmx.de>
	<20090122231028.GB29236@pandem0nium>
In-Reply-To: <20090122231028.GB29236@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3301085.U5acSUuAtq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901230126.27298.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batmand-howto conversation
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart3301085.U5acSUuAtq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 23 January 2009 00:10:28 Simon Wunderlich wrote:
> thanks for your work, it'd be nice to keep the howto up to date. We
> might as well merge the howto with our ongoing documentation [1].
> What do you (and the others) think?
Hm, sounds interesting, but I see different problems. First thing is the=20
different copyright. You specified GPL2 for the batman(-adv) documentation =
and=20
Wesley released his stuff as CC-by-nc-sa-3.0. These licenses aren't compati=
ble=20
in the way that you relicense his work under the GPL2 [2], but you can ask =
him=20
if he relicenses his work.
The second thing is that somebody has to rewrite it into XML Docbook. This=
=20
isn't that bad but I will definitely not doing anything like that until=20
somebody explained me why you are using a SGML Docbook tool to convert a XM=
L=20
docbook to your target format. When you try it on another distribution than=
=20
debian etch/lenny you will propably receive an error (try for example one o=
f=20
our public accessible machines at tuc).=20
And maybe somebody can answer the question what is the right way to do the=
=20
conversation job? I found different references that their is/was some xsl=20
stylesheet to convert them to pdf but I don't want to fiddle about xsltproc=
=20
and different xsl paths on each plattform. I tried xmlto some time ago (sma=
ll=20
shell script which does all the xslt stuff for me), but the output was quit=
e=20
bad and it had problems with the images (hm, reminds me on the fact that th=
e=20
current way the images are handled inside batman-adv-doc is a hack too).
The last thing is that the target audience is different. I don't think that=
=20
mixing the two ideas together. Maybe it works when their would be
* part 1 - batmand - algorithm, implementation, usage, ...
* part 2 - batman-adv, differents in implementation, usage, ...
=2E.. or something completely different

> Anyway, i'd upload the updated version of the howto as soon as you
> consider it ready.
Tell me how something could be ready which describes another object which=20
hasn't reached a final state and probably never will. But I don't intend to=
=20
change anything in the near future. Everything Wesley did is included, new=
=20
informations are merged and images are scalable. So proceed further as you=
=20
wish.

Best regards,
	Sven

> [1] http://gitorious.org/projects/batman-adv-doc
[2] http://www.gnu.org/philosophy/license-list.html

--nextPart3301085.U5acSUuAtq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl5DqwACgkQqQGwKVlMoDuhtgCfduBJMo2GUkpT1T+2Th8i/kyG
QGcAoJqzoNsA7wavqB3YnAUu/GBi3NwB
=p9JB
-----END PGP SIGNATURE-----

--nextPart3301085.U5acSUuAtq--
