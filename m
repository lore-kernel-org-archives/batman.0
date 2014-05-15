Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 16 May 2014 02:57:12 +0800
Message-ID: <3648887.FFZtOA1qDo@diderot>
In-Reply-To: <1400144887-24455-2-git-send-email-antonio@meshcoding.com>
References: <1400144887-24455-1-git-send-email-antonio@meshcoding.com>
 <1400144887-24455-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2819849.NNUsbkDnnj";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: fix var name to
	keep compatibility with old kernels
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2819849.NNUsbkDnnj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 15 May 2014 11:08:07 Antonio Quartulli wrote:
> The first argument of kfree_rcu() is used in compat.h to forge
> a function name used by old kernels. Keep it as it was before
> to avoid breaking this compat mechanism.
> 
> Introduced by 9729d2085c0fa4398eb1ee518b0097866dfdcd77
> ("batman-adv: fix TT VLAN inconsistency on VLAN re-add")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  soft-interface.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied in revision b539153.

Thanks,
Marek

--nextPart2819849.NNUsbkDnnj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTdQ4IAAoJEFNVTo/uthzAGYEH/2fOaRveiCQlkW+d8UnGJ7Se
F9zL1FO4PDBCwUs+DQeKk+NDNmVExSqXOVv/G0R4TXImkszTblF8z0cmPsPTe+7F
v8ovnk7iQWOf/mccUmsqCQZyD6CibKP6oo2G8g2svDFvgULVjt41ozn9rPY4xCki
u5FC4GuEVS9l/KzKb1axbpz1OGbtI4JPR9h3LeVF8kNxMxM6CNa5gHjDxC+QuaHt
NExNWZN51gzQWge7oKtFqJxolbQVGwo9LMn9kwH7IMrzj26b8LZFg1e3M5o7D3Rs
9sUFyuf68cgo7bzL6jXqrfh0EIGM2s+OFX1RfTHk6kRKn949GoNpDmoK9QQoRAc=
=22C+
-----END PGP SIGNATURE-----

--nextPart2819849.NNUsbkDnnj--

