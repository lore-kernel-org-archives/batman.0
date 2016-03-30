Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 30 Mar 2016 18:08:49 +0200
Message-ID: <2628962.NH5e8Bopbi@bentobox>
In-Reply-To: <20160330135842.GA19985@r2d2.s.lihas.de>
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart91213858.UNKCRtitLm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart91213858.UNKCRtitLm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 30 March 2016 15:58:42 Adrian Reyer wrote:
> A current setup of a freifunk gateway in my freifunk-community hast 2
> interfaces attached to a batman instance, 1 fastd reaching all the
> nodes, here we absolutely need rebroadcasts and 1 tinc interface
> connecting alle the gateways, there we have full mesh due to tinc
> already and don't need rebroadcasts. Both interfaces are just
> tap-Devices, e.g. tap0 and tap1.

I never used fastd. So maybe you can tell me if I summarize it correctly:

 * fastd creates point2point vpn-links and makes all of them accessible via
   tapX
 * fastd only sends broadcast to its direct neighbors (vpn-links)
 * the fastd daemon doesn't set some flag to indicate that it doesn't really
   support broadcasts
 * you want batman-adv to behave on this tapX exactly like on adhoc (maybe
   with less re-broadcasts than on adhoc) to keep everything in the same
   broadcast domain

And for tinc you most likely have configured mst for broadcasts ("tinc
handles the forwarding via spanning tree") and don't need batman-adv
anymore for re-broadcasts.

Kind regards,
	Sven
--nextPart91213858.UNKCRtitLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW+/oRAAoJEF2HCgfBJntG4QIQAJbfiRHmG7XuWnEFpKYesgnD
Ej7w2ImXUwc5S1oQBAQJyY0mWKE8k3rbclRYdOcRyw2NipAtQdMflaBYHbHBxirA
ztAgj+qeXWhcSwCKerCukm6zd8beoRq2hU0b7WMIOPyed8IzHLd0rblmGWw+kNtd
uXtn2Y6/3L+fi5//SKIjb0C/r0edHe0PlMcZ4xTw0pdXIRYsTGQ6pmAg5YuxWohd
abrD1e4Yst3o6Ii2LyPQAFNwpU+dC5StMafJOOWXMARKGgS7r3+9d/APVMKmeA9J
oPFdAXaTOs3LpaWiY3Qx40DyND4IHWIuSyXd1ojlrfGhqrkCoZPXOmmhyHVQkH+A
xFFq84u3sHhNf3RHM1rCChXaRXrZOQcjAgHrTvpBfK8A3SSFpownbcS7CY6yW2ZL
YI7iUPN/o3Ow/KJ415IuQIc9LJf8LxtLgUcHjgm25H2IBW2j7RpDR6nfAbTyvriz
AyeRgIzMyX/Aligmq2FLibIHpM+HlS5c4VPT/WmySocwZ/Kpokr+ICU9Ba5xU+Vz
xxaX/ndy8xl9TcU5HHpov9OTpHYdNTCbt+PosnxcPJAKO9iw+Fve4wbto2JcZPEO
GfIaAC521IlXtoW9y2oVBalrW7hdPlVNhE6Zp3vu/lJ9zxP438gAPAZFUOxDwq4x
Pe6UkpNK2P5BomCeaWhC
=UVxM
-----END PGP SIGNATURE-----

--nextPart91213858.UNKCRtitLm--

