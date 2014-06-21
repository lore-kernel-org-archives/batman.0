Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 21 Jun 2014 14:57 +0800
Message-ID: <1580359.WRiNmDpua1@diderot>
In-Reply-To: <20140620155712.GU29033@Linus-Debian>
References: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
 <6992822.ghf2EUPW9C@diderot> <20140620155712.GU29033@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1811534.7ooy6JWWPa";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast optimization
	support for bridged setups
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


--nextPart1811534.7ooy6JWWPa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday 20 June 2014 17:57:12 Linus L=FCssing wrote:
> tl;dr: batadv_mla_softif_get() is for multicast listeners *on* a
> batman-adv node, batadv_mla_bridge_get() for multicast listeners
> *behind* the bridge of a batman-adv node.

Ok, I get it now. The diagrams certainly helped. Please highlight the=20=

difference between these functions in the kernel doc.

Thanks,
Marek

--nextPart1811534.7ooy6JWWPa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTpSzEAAoJEFNVTo/uthzADHgIAJawFyF/Q+FsRWPjIBs3rsJ3
RQv4E15/Oi3B+W7vOVv1zNQiKKx8QhJ4ZkLv98d0tuzs+NNlfNg0DMcfHlqCzSlZ
EYAK8acMsy6+f9BaXFVq391bt0emV+MG15gVwTrGxzLRMBMB1ak9VolG/B+vNBsO
EokshkirfxK2bducpIlrJ59qCrxmnoF3TFZSCThvNP25kswXBRan370+X4sv5nML
VNeXSG8JzbbGvSpCqOo6TA/x8g4M9ivRzo1KzNTIq4RGbSeqU6A2eBPsTY7OWGi7
NT+ZBKP8KCzeMsAffweyg4gDXMoIVXAVTtVfdG3hmwYl/AWpNDychm1ElSn4S58=
=CLHg
-----END PGP SIGNATURE-----

--nextPart1811534.7ooy6JWWPa--

