Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:12:54 +0800
Message-ID: <4391661.77fCcNH0tR@voltaire>
In-Reply-To: <1452933619-6712-4-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-4-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2391438.afZ2av3iJc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 04/12] batman-adv: ELP - adding sysfs
	parameter for elp interval
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

--nextPart2391438.afZ2av3iJc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:11 Marek Lindner wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> This parameter can be set individually on each interface and
> allows the configuration of the elp interval for the link
> quality measurements during runtime. Usually it is desirable
> to set it to a higher (= slower) value on interfaces which
> have a more static characteristic (e.g. wired interfaces)
> or very dense neighbourhoods to reduce overhead.
> 
> Developed by Linus during a 6 months trainee study period in
> Ascom (Switzerland) AG.
> 
> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> [antonio@open-mesh.com: respin on top of the latest master]
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net-batman-adv | 8 +++++++-
>  net/batman-adv/sysfs.c                               | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)

Applied in revision 82da7d6.

Thanks,
Marek

--nextPart2391438.afZ2av3iJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlJ3AAoJEFNVTo/uthzA5MoH/iOlTfytQ+hUUF82Y2FsWhu1
t2bG0vhXwyFXTSCPlwfAVs+YPaEKBJqiVQ2Oex/ob7w1/r14VZV6U6WN2C2uybRq
NsFIAjelpdsmtfoKJenbJE4HXatMKmX9Cn4H14tPVtQpsZkFHt1Qsqh7xfJ3E2P4
oni/GuA5synysbyFind+tTELJ1vB7QvDgK5GTxV01jamP0anXDtx4La+ImnGKDgQ
iR4nVH+dh4f53FC2tYun+ly0DaUVcY+GeLoF0HXKFFXz8NuUoXgXvFELNcWQAaUv
ikbytKPfCdjeTqElWCTrkuAKKWb9yDGUIparTT+JYK5Zbv508Fpy5MdFRZ9KM7s=
=QYyT
-----END PGP SIGNATURE-----

--nextPart2391438.afZ2av3iJc--

