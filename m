From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 25 Jan 2009 16:15:40 +0100
References: <200901212136.01338.sven.eckelmann@gmx.de>
	<20090122231028.GB29236@pandem0nium>
	<200901230126.27298.sven.eckelmann@gmx.de>
In-Reply-To: <200901230126.27298.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1372068.lFvrqDmMCp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901251615.40954.sven.eckelmann@gmx.de>
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

--nextPart1372068.lFvrqDmMCp
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 23 January 2009 01:26:18 Sven Eckelmann wrote:
[...]
> Hm, sounds interesting, but I see different problems. First thing is the
> different copyright. You specified GPL2 for the batman(-adv) documentation
> and Wesley released his stuff as CC-by-nc-sa-3.0. These licenses aren't
> compatible in the way that you relicense his work under the GPL2 [2], but
> you can ask him if he relicenses his work.
Ok, I asked him and he agreed.

> The second thing is that somebody has to rewrite it into XML Docbook. This
> isn't that bad but I will definitely not doing anything like that until
> somebody explained me why you are using a SGML Docbook tool to convert a
> XML docbook to your target format. When you try it on another distribution
> than debian etch/lenny you will propably receive an error (try for example
> one of our public accessible machines at tuc).
Pushed fix in a clone of your git repo and requested merge.

> And maybe somebody can answer the question what is the right way to do the
> conversation job? I found different references that their is/was some xsl
> stylesheet to convert them to pdf but I don't want to fiddle about xsltpr=
oc
> and different xsl paths on each plattform. I tried xmlto some time ago
> (small shell script which does all the xslt stuff for me), but the output
> was quite bad and it had problems with the images (hm, reminds me on the
> fact that the current way the images are handled inside batman-adv-doc is=
 a
> hack too).
Seems to be better now. xmlto with fo output +fop isn't that bad. Their are=
=20
problems with images when you try to generate pdf directly but generating p=
s=20
and then pdf works fine. I read that renderx xep works better, but it is a=
=20
commercial tool.

Regards,
	Sven


--nextPart1372068.lFvrqDmMCp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl8ghwACgkQqQGwKVlMoDv3YgCeMocfJHfNuLhlLMPhJYPE2Ikd
uXwAn1RAX6uAN9FA8B9j/81y9xVA3jCZ
=kkaF
-----END PGP SIGNATURE-----

--nextPart1372068.lFvrqDmMCp--
