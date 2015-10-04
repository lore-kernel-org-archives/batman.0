Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2015 18:41:40 +0200
Message-ID: <3035214.3FFCJO0HV9@sven-edge>
In-Reply-To: <37028290.5tXI0TbgDB@lappi>
References: <37028290.5tXI0TbgDB@lappi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1555984.z7I8fKPssx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman-advanced-dkms + debian + kernel >4.1
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: info@wifi-frankfurt.de, thomas@t-8ch.de

--nextPart1555984.z7I8fKPssx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 October 2015 16:24:11 Christof Schulze wrote:
> Hello Simon,
> 
> when trying to run batman v14 on a current kernel (I noticed it for Version
> 4.1) I realized that batman will not build beause the netdev-structs
>   have changed.

v14 is not maintained anymore in the official batman-adv repositories. You may 
instead try to contact the developers of the batman-adv-legacy [1] gluon fork.

> The solution is fairly simple because the fix has already been
> implemented in newer batman versions. The function
> batadv_is_on_batman_iface can be copied from there and is working fine.
> 
[...]
> 
> Now: Where is the correct place to implement the patch: in
> batman-adv-dkms or in batman itself?

Which batman-adv-dkms? I was maintaining a Debian package with that name but 
this was dropped a long time ago... I think 2011 or so. But I would guess that 
you want to add a patch to your "batman-adv-dkms" that patches batman-adv so 
dkms is able to build it against your current kernel. Or get the patch 
directly into your batman-adv v14 fork... But this is nothing Simon or I can 
help you with because we stopped working on v14 and batman-adv-dkms years ago.

Most likely you are talking about gluon based batman-adv-dkms [2] package 
which is also made by the batman-adv-legacy people. But these packages clearly 
states that Matthias Schiffer <mschiffer@universe-factory.net> is responsible 
for them (ok, he forgot to change it maintainer name in 
debian/control.modules.in and didn't update the upstream addresses). So you 
better contact him when you are using his forks. He most likely has complete 
different ideas how this patch has to look like because he isn't interested in 
getting it merged into the official Linux repository.

Kind regards,
	Sven

[1] https://github.com/freifunk-gluon/batman-adv-legacy
[2] http://repo.universe-factory.net/debian/pool/main/b/batman-adv-kernelland/

--nextPart1555984.z7I8fKPssx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWEVbEAAoJEF2HCgfBJntGIaEP/0Rn+ZJxz/y382N+iJOLKI1o
uwhV0wb7pxHXglxBu1/p2RXh8qCGtKQ9PNTf6ZT41qpucQVqV2OyzFORvMeON0Yd
lAIQBrIvjx78B8gMz4EN5HLmmRMWOPY1jvqtDSngHNNpb2g98trkmoiVjwGUc0ui
/QYFFmM1gSSxEx79Y+V4hpWzMvnM3ce4r7QaKserVualUMvuJA3oujh/6vbl5S5v
Fgc8yKXkhYf4ZYFY/5WIBSyaJ51jkzb8+D26C284k6UXqURoCm6iBJJGLKW2TVlp
z975wdgsliCrrdK/Yd8TaDUJhm14BnNrh7+2PInoYyhpaFOXCMDX8AQTfy6TH81x
T/ig0b/BBKn0zUcI/3xwru1yggoRBv59eExVYR1bnEwoJsrOHe5j5xPz6ffv1QgD
RGN07FD3OI8Lykrc5Aml2+3maulDy7m2cp/C5THnH6XqIuHdCM4JNtViO1zmB4WY
B8xgqllD6yB3ixxUeScIAF0XuBSf9+qkaXmNpjiC9OwC4AMihvcKKoOoWx6bmprG
49IDD7kYiVo08k0FOsOZbKvpdwhEAPCDGbPN9BUk3d/hEWx77ypRRaNipuTGgGWV
t6XgmJQW7GzcM/JHlPo0+bw2N+v6FbWVNlXUWmbhEAfvfhvtLycVDz6GQ43JgKgi
oAdmOWpci0HDM7pqV8/j
=agHQ
-----END PGP SIGNATURE-----

--nextPart1555984.z7I8fKPssx--

