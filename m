Return-Path: <antonio@meshcoding.com>
Date: Wed, 20 Nov 2013 16:38:58 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131120153858.GC311@neomailbox.net>
References: <CAAxzKbRaF_a5UZdZUUQXmgO_zEp=Fe2_AdTAfSOKrTX=rFpq2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <CAAxzKbRaF_a5UZdZUUQXmgO_zEp=Fe2_AdTAfSOKrTX=rFpq2A@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Automatically starting adaptors at boot
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2013 at 01:36:16PM +1000, tjhowse wrote:
> Hello Ladies and Gentlemen,
>=20
> This might be a question better suited to the OpenWRT list, but I
> figure it would've been solved better here.
>=20
> I've got a two-node mesh set up and working well. Config files are
> below. I have some minor woes though. Each time one of the nodes boots
> up I must:
>=20
> brctl addif br-lan bat0
> ifconfig bat0 up
>=20
> ...before traffic starts to flow between clients connected to the
> wlan0 radios of each node. What's the best way of having this happen
> automatically? I assume there's a better way than having an init
> script run those commands at boot.

This is totally related to openwrt and unrelated to batman-adv.

If I remember correctly you can directly configure the lan "interface" in
the /etc/config/network file. You should be allowed to specify more than one
ifname (in the same option line).

The openwrt channel/documentation can probably be more helpful.


Cheers,

--=20
Antonio Quartulli

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSjNeSAAoJEADl0hg6qKeOzLkQAMK2TAeE0uWh6hQPrKc+gNc+
H2PnrbHv5MY9G36tRg6Wem9OYjWMWyVm+7DIX+ZHfQOwLkXMQxgJP4DYF1E9X3mH
KBx0hbBNmQYb1PYaItdb4uFJHHXFzQRC9UhSGe2SLApy1e+Wm26sfk3PNCF34MtH
VTnf17LCwf+90f0uJzy0LnqccOwOiT7FRn5WiNWW60cFWSKPU8rS92SU6XHq9etM
qUXA/g48HC/9YbWCCtgkcv3OLGgWai+iAXrq8uAvpVOydLQgb8QrLkpTA66Xp0CB
oCWdWmek3IC8GKahdOgZM+hlwpQRr926tFTIUtW0pzQJfBtWBpQtkHsz18NYokUX
WpsPQRusoZsdx2tdOnA/HlsNN/wUVpu5RmwIQB+vGwREDQKdC3SseInVsdYqfhwA
i+prVDNPW2FZdJSqL6qYnJp75QO1IKxsIyRmZ8sbTZvPBjCAaRCzSdUpBohC6Muw
+inwkDxNS8aDxTRzMt2nsubUOkyUSDi3yk0RT0DbMO0GiF9gJBzLX+kSaondAb4F
MLQXdmyTss3pSdecrrF9WT+t/Lrow7iQC9yXpXTpSD5/WQxWWqs0R+CDntg7olSI
CTp3j6GIotx0ZMSvk5d+lAJD8rXBs6ff6sV7GS4GpYbwj5LFqGtQvC8tF/SmKlcz
z8Z53vtAJIcjzehaP+f4
=jA6l
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
