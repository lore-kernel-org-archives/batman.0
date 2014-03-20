Return-Path: <christof.schulze@gmx.net>
From: Christof Schulze <christof.schulze@gmx.net>
Date: Thu, 20 Mar 2014 19:59:16 +0100
Message-ID: <1629001.Cx5dbnsKCT@lappi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4156369.0Y5P3iMNZE";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Batman-adv  + lxc
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart4156369.0Y5P3iMNZE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hello,

This is my first post to this list. I would like to run batman-adv
inside an lxc-container just as described in [1]. I do not want to do i=
t
to simulate a network having multiple nodes but to separate duties of
different "virtual machines" - linux containers in my case and to be
able to easily migrate the configuration to a differen machine lateron.=


I started by loading batman-adv on the host and bridging it into the
container.  After adding the interfaces inside the container where
meshing should happen I cannot add a gateway because batctl complains
that /sys/class/net/bat0/mesh does not exist. Indeed, in the container
it does not exist.

How can batman-adv be used from an lxc-container?


Christof

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-September/00=
5355.html
=2D-=20
()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments

--nextPart4156369.0Y5P3iMNZE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iEYEABECAAYFAlMrOoUACgkQpZfyPAmdZJmV+ACfQdPChr5ebGVK5MeehTxMoNm2
nTIAoL0hxKSLFhYoQQQTSgyMs7xnYq2c
=UcDz
-----END PGP SIGNATURE-----

--nextPart4156369.0Y5P3iMNZE--

