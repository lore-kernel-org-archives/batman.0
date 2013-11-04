Return-Path: <antonio@meshcoding.com>
Date: Mon, 4 Nov 2013 15:11:58 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131104141158.GH970@neomailbox.net>
References: <1382875379-2921-1-git-send-email-antonio@meshcoding.com>
 <1382875379-2921-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r21wuLfwIlf/vvzy"
Content-Disposition: inline
In-Reply-To: <1382875379-2921-2-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: rename gw_deselect()
 to gw_reselect()
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--r21wuLfwIlf/vvzy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2013 at 01:02:59PM +0100, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> The function batadv_gw_deselect() is actually not deselecting
> anything. It is just informing the GW code to perform a
> re-election procedure when possible.
> The current gateway is not being touched at all and therefore
> the name of this function is rather misleading.
>=20
> Rename it to batadv_gw_reselect() to batadv_gw_reselect()
> to make its behaviour easier to grasp.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  gateway_client.c | 35 +++++++++++++++++++++++------------
>  gateway_common.c |  2 +-
>  sysfs.c          | 10 +++++-----

The declaration of this function is in gw_client.h but I forgot to change i=
t.

v2 will follow.


Cheers,


--=20
Antonio Quartulli

--r21wuLfwIlf/vvzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSd6suAAoJEADl0hg6qKeOYagP/0HLCwyRejEVPiUPL0/eLeix
+WPqanvqfGD1os+Bptia9gMQpWtqHEyMazNWw+1ucgDjk3pKjrJ3rWy1Yy/qT2xT
fRCvQFcW3kmYMHcf9hdGGCTdXFZ/55D/8SIPCjS3oCcWBV9Tp8vAkiu0KNRNuf4m
sKXhVEihoyPPT4kBOTBPMw1d5SAduXppwSuw1fLubi+HF8RuF7LhHuFiv+tUpkHL
aJmUbJiCWSa9iePXxxCkgrgYdl80szYp0lbNT//6MdT5euHDrHYmdUWmhkmB+nv4
DFsJ0yeRVIBhZAgWj385/181Fk2Ityi1HjSdDZJdxsyQX/wlMW/RO2TPUyUR2B1p
Y+ElRtY5P7EFmF6H3pQPbUzRT30hwpYsmlpZLjuEwiCnK+NGBuBWRC6vbxoMr8c6
wWytKDIzOlbXCDYNLrAtjejeX4u3bR+cy/YLdbpe1dP162vycUn0bCeSl2KKfNRu
2zwcckAPEUgChe+jIuUgj6EAwEbbwQrFzSacyJ2ZmzLIlf7RFBFQrnWvAM/Oxd3O
Cp3fbsX0jCAHYCBBwTbg+wD8pqwPawOFwveaHA3GbhXToP3vVuXaqePYIObYyIpk
rt3fOsnaelSqVC4j6Q/ZZcNRGQQfNNgnycuzkWuWEKc9AJlpBuWsefutNhbZ3yHP
XOkKn537KDIGuWGvJ61B
=iMkW
-----END PGP SIGNATURE-----

--r21wuLfwIlf/vvzy--
