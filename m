Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Aug 2018 12:30:00 +0200
Message-ID: <3991773.ZLWj8GO7DM@bentobox>
In-Reply-To: <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
References: <2791173.mX5NbDZpiX@sven-edge> <2950360.XQPVAlnd6X@bentobox>
 <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3461722.u2IGQRlGLz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ligang LIU <heishuihe2008@163.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, a@unstable.cc, mareklindner@neomailbox.ch

--nextPart3461722.u2IGQRlGLz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 31. August 2018 17:52:39 CEST Ligang LIU wrote:
> 1. many unicast packets, with length of 200 bytes. I guess it's ELP unicast.
> 2. some batman-adv broadcast packets of 56 bytes length. I guess it's OGM2?
> 3. several batman-adv broadcast packets of 16 bytes length. It's ???

First two are correct and the the 16 bytes one is the broadcast ELP. I 
personally have no idea at the moment why the requested padding [0] was not 
implemented.

Especially because this frame will now be dropped over some interfaces. We 
already saw this in the past with fragmented frames [1]. You can increase the 
size in batadv_v_elp_iface_enable by adding the number x to the alloc and the 
skb_put. For example 44 to get to the minimum ethernet frame size:

    hard_iface->bat_v.elp_skb = dev_alloc_skb(size + 44);
    ...
    elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN + 44);


> 3. many rts/cts/ack packets.

Is it possible that RTS, CTS + unicast retries take most of the airtime in 
your setup?


> I noticed 2 macro definitons.
> #define BATADV_ELP_PROBES_PER_NODE 2
> #define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
> I wonder why it sends 2 prob ELP packets to each neighbour.
> Can I change the value of BATADV_ELP_PROBES_PER_NODE from 2 to 1?
> And can I decrease ELP prob packet size from 200 to 100, in order to decrase the ELP airtime?

@Antonio, @Marek: Maybe you can explain it better than me.

I would guess that Antonio wanted to make sure that the rate control algorithm 
of the driver probes enough and thus provides a more realistic expected 
throughput.

But I would guess that the size doesn't matter much. It is more likely that 
all the stuff around the actual data frame (rts, cts, IFS, ...) takes more 
airtime.


And you can just use elp_interval [2] to reduce the number of times broadcast 
and unicast ELP frames are transmitted. But yes, reducing the number of probes 
per node might also be interesting. There is also BATADV_ELP_PROBE_MAX_TX_DIFF 
to reduce the time even further - but according to a comment [3], this may
make problems with minstrel. But I am not really sure about that because the
default elp_interval (500ms) is also already larger than 100ms.

Kind regards,
	Sven

[0] https://www.open-mesh.org/projects/batman-adv/wiki/ELP#section-9
[1] https://git.open-mesh.org/batman-adv.git/commit/11a0c90b439190fd6a104caac5d4ef09e1f65a96
[2] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#ELP-interval
[3] https://git.open-mesh.org/batman-adv.git/blob/89dcbd5f2373b955fc8eabb909f6188ae33110b7:/net/batman-adv/bat_v_elp.c#l218
--nextPart3461722.u2IGQRlGLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluJGKgACgkQXYcKB8Em
e0agnRAArDrBBhmUHusLy0k3iBogwE7U7igcj16g6w1vDOVsx1itqeSV7/kr5cg5
bhrh+wfJRki3Nbpzu3V076G26oyyv2yTXtjzn2jumsWtysrYC7kaXzRy/Px6Ksk5
/Ea0bH2gJfsH3Psne0Hqj0lPU6F/LsROosfg4ylNJ0xT+zsCdAGiWpgVnR3d1ubI
J5aFs3oJacqZyWCbIKDrS7i1vxQQVPhVyQAVIpytcJq/355B0Vlc6MEq09O392ru
1+QVivJ675yZnZ6V1c2ClTL2CrUxa69orpIB91yiPcw02DJMgKhaHWnlIbrY7eM4
Geza+z0VhnXGqQB9w0RwQcchi1uzN337Bc0JLM03GTjzarBiuQTalxv/alK2QCBC
RnKGujBikpAFMmSdsUHTxEot2rij2Jt9q5VaJYjmworpto1+bBkD2KyQA14daSDL
vGFwfk1/RHiNvxJWn9P+bD9mOs1cXcZD7GcDCnCaP0IrPLj5IShHg7CalRrEshyF
NLsKE6+Tao9hSwGGYcnUpQ0AND4nx5t+83h37fCH06sq/+b/Hb6Oinu/eX7nOhRG
oJwauDb9OXRQPrI9pxSwujfc/LDTmRze1t2BmruVRk/f6p9vSdEsgrOTkGoKQhYG
i9gIo0PU9FLaI2yp0mh5bA7FIIqEc5MuzZH1eVZCZ18ykXnF9Tc=
=KIke
-----END PGP SIGNATURE-----

--nextPart3461722.u2IGQRlGLz--

