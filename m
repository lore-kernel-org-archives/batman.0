Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 17 Apr 2012 11:25:31 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120417092530.GA10402@pandem0nium>
References: <4f8bf5df.68c5440a.5c0c.5258@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <4f8bf5df.68c5440a.5c0c.5258@mx.google.com>
Subject: Re: [B.A.T.M.A.N.] Problem with multi-radio,
 multi-channel in batman-adv
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Puyou,

On Mon, Apr 16, 2012 at 06:35:04PM +0800, puyou.lu wrote:
> Hi guys.
> =E3=80=80=E3=80=80I=E2=80=99m trying to make a for nodes WMN using four d=
evices with two wireless cards each. I would like to use three different ch=
annels to reduce the interference, like this:
> =E3=80=80=E3=80=80[Node A]  <- channel 1 ->  [Node B]  <- channel 2 ->  [=
Node C]  <- channel 3 ->  [Node D]
> =E3=80=80=E3=80=80First I configure eight wireless cards to the specific =
channel in ad-hoc mode using =E2=80=9Ciw dev wlan0 ibss join =E2=80=A6=E2=
=80=9D.
> =E3=80=80=E3=80=80Then, I think I should add wlan0 and wlan1 to the same =
batman-adv interface (that is bat0) in every device. So I need to configure=
 four nodes with the same commands like:
> =E3=80=80=E3=80=80              echo bat0 > /sys/class/net/wlan0/batman_a=
dv/mesh_iface
> =E3=80=80=E3=80=80              echo bat0 > /sys/class/net/wlan1/batman_a=
dv/mesh_iface
> =E3=80=80=E3=80=80Last configure an IP address to each bat0. (Node A-10.0=
=2E0.1, Node B-10.0.0.2, Node C-10.0.0.3, Node D-10.0.0.4).
> =E3=80=80=E3=80=80But it seem Node A can reach Node B and Node C(using pi=
ng), but can=E2=80=99t for Node D.
> =E3=80=80=E3=80=80
> =E3=80=80=E3=80=80Am I following the right procedure?
> =E3=80=80=E3=80=80Sorry for my poor English. Any help would be appreciate=
d.

The procedure looks right in general. A few questions to debug:

 * do you use different ESSIDs for the IBSS-networks? ad-hoc devices joinin=
g may override the configured channel
   and select another IBSS-network instead when it has the same ESSID.
 * have you confirmed that the WiFi connection works without batman-adv? ju=
st set up your WiFi, configure different
   IP addresses and ping for each hop to test.
 * does the output of "batctl originators" helps you? Are the other nodes d=
isplayed on node 4?

Cheers,
	Simon

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk+NNwoACgkQrzg/fFk7axam9gCgnRloiq9bQnHUFp5mz1zrTX9L
nRcAoK23+ILPhPljEOSlPZd49+Dx2OTw
=FJQT
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
