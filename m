Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 31 Mar 2014 20:35:08 +0800
Message-ID: <2097856.IRUVR4aqtZ@diderot>
In-Reply-To: <1396266490-3525-1-git-send-email-antonio@meshcoding.com>
References: <1396266490-3525-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12592874.WSDhIxRvie";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: change the MAC of
	each VLAN upon ndo_set_mac_address
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart12592874.WSDhIxRvie
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 31 March 2014 13:48:10 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The MAC address of the soft-interface is used to initialise
> the "non-purge" TT entry of each existing VLAN. Therefore
> when the user invokes ndo_set_mac_address() all the
> "non-purge" TT entries have to be updated, not only the one
> belonging to the non-tagged network.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Changes from v2:
> - don't increment/decrement vlan->refcounter because we never use the vlan
>   object outside of the rcu_read_lock/unlock area
> 
> changes from v1:
> - declare vlan variable
> 
> 
>  soft-interface.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied in revision 31f3914.

Thanks,
Marek

--nextPart12592874.WSDhIxRvie
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTOWD/AAoJEFNVTo/uthzA4csIAJVTnexMQWGeX659p5AgrvW/
ucPwrQPujckUiKQ/coo3N8SrK0iqipEAl1N5/La9TVn6062DO+V4Nxh93ygWCWCW
kbEJ82aN6IMqqeLjC50uh5VOJjmRfaczme4u24n30TDy1hK2REtlcNYHqHFwrDo/
OO7Ftf53F25p3TkQFldc3yq/YAq8WsZme0y6c/LMS/svuTVVyGHk7kue3gsYWuE4
qnEQb7QLeZXgabZ5qSUsZukaP934wiOEwPHfUHYGncClSAPkY1wY+tAjjxOg9i+G
HwyifExxjh4cXnFJ20ULxtmXXCZYcT1FVWMlgPajZ3z1JtM6Qc8159T0saaTvOc=
=O9br
-----END PGP SIGNATURE-----

--nextPart12592874.WSDhIxRvie--

