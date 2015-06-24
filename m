Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 24 Jun 2015 16:07:05 +0800
Message-ID: <3385207.9vQFyjtv9T@voltaire>
In-Reply-To: <5588386B.50604@meshcoding.com>
References: <1434904911-12504-1-git-send-email-mareklindner@neomailbox.ch>
 <5588386B.50604@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1620248.sDRAQxF6uS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: protect tt request
	from double deletion
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


--nextPart1620248.sDRAQxF6uS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 22, 2015 18:31:39 Antonio Quartulli wrote:
> Signed by antonio@meshcoding.com.	Show Details
> 
> On 21/06/15 18:41, Marek Lindner wrote:
> > The list_del() calls were changed to list_del_init() to prevent
> > an accidental double deletion in batadv_tt_req_node_new().
> >
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 9bac35c.

Regards,
Marek

--nextPart1620248.sDRAQxF6uS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVimUpAAoJEFNVTo/uthzA6L0IAIZB0KdGytVn+3nRSTsskm/g
BzRVATjAVieOuGoG7jfjj6mc0aCwAQlqHqJ3OvNmfky6LslxDDUFmXka3sBZuoBj
hc7juJljoXL3VH2EG+k0nB+ZEQqvi3N4qtJknkQHgLtHizlelhB7LPEhF/JVgZlU
h4MqxKGCQjf33a3wH+4CMAlSC4KPue/8NcrRQIdKE4dcnjNd5QGKQc1/EAaAmNF3
wjVKw0lQ+VR4+Zkd1Lw4fNIeL7WCB/RbxwGufDxiKmRhsjXrXCQnrSMTErcatEcP
qgP/9PdxXttqHLbMvDuWsH6MEjd3+CFQ8hcj4v9QS6rIGaVmWua3ejGvlOPBNmk=
=7mpP
-----END PGP SIGNATURE-----

--nextPart1620248.sDRAQxF6uS--

