Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 01:38:03 +0800
Message-ID: <10700506.U0uT5FNO6d@voltaire>
In-Reply-To: <1462464426-13014-5-git-send-email-linus.luessing@c0d3.blue>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <1462464426-13014-5-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5068543.QyeNTlhVhT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 4/4] batman-adv: Add debugfs table for
	mcast flags
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

--nextPart5068543.QyeNTlhVhT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On T hursday, May 05, 2016 17:07:05 Linus L=FCssing wrote:
> +                       flags =3D orig_node->mcast_flags;
> +
> +                       if (!(orig_node->capabilities &
> +                             BATADV_ORIG_CAPA_HAS_MCAST)) {
> +                               seq_printf(seq, "%pM -\n", orig_node-=
>orig);
> +                               continue;
> +                       }
> +
> +                       seq_printf(seq, "%pM [%c%c%c]\n", orig_node->=
orig,
> +                                  (flags &
> BATADV_MCAST_WANT_ALL_UNSNOOPABLES ?
> +                                   'U' : '.'),
> +                                  (flags & BATADV_MCAST_WANT_ALL_IPV=
4 ?
> +                                   '4' : '.'),
> +                                  (flags & BATADV_MCAST_WANT_ALL_IPV=
6 ?
> +                                   '6' : '.'));

Little nitpick: Can you please move the flags assignment closer to wher=
e it is=20
used.

Thanks!
Marek

--nextPart5068543.QyeNTlhVhT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK4T7AAoJEFNVTo/uthzAHuMIAKppS/k+Xi5aVRvKOIKhkFG8
8rIEnWdjG0WHGfHgmdbw++/Qibm4jTs7PC2NiSM3vPkSQhfIL4xe6kUOHGQWwHcz
CBqetybuj49sVAABRi9Hhh2f2xtZhwbwqOZALCbMOu4OkipJb4opJ2DAQQG0jwVK
yIdXLgj2wd9OvsYpTnYC/r8fGH2itljbsKMKZ6s2kcyG8qRmNznG3AwL4mb1gYcn
P6ecYIRpESIurxy0BfGPsuO43Ja/ZGmppJqKZENCylfTLPD8Iz46iJlP3KvxpxwZ
hgcM1JNsvyN+Qsm4TA5AIllDH4/XYaPKGWAdFbXCxovJx0LgpYKsDvqvJChOzeM=
=bbyl
-----END PGP SIGNATURE-----

--nextPart5068543.QyeNTlhVhT--

