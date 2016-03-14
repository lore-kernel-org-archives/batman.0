Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Mar 2016 11:57:40 +0100
Message-ID: <15512323.RRrA1BdBoh@bentobox>
In-Reply-To: <1457895034-13823-6-git-send-email-sven@narfation.org>
References: <3465881.llCNFeNLl4@sven-edge>
 <1457895034-13823-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart42883157.KAQGEl6LGP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/6] batman-adv: debugfs: Add netns
	support
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

--nextPart42883157.KAQGEl6LGP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 March 2016 19:50:34 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Unlike sysfs, debugfs is not netns aware. So batman has to take care
> to avoid namespace clashes.
> 
> Each namespace is given a directory within debugfs/batman-adv/netns,
> using the namespaces inum as the directory name.
> 
> Files for namespaces other than the global namespace are placed within
> the namespace specific directory. Additionally, a symbolic link is
> used to link the global namespaces inum back to debugfs/batman-adv/ so
> tools do not need to differentiate between the global namespace and
> other namespaces.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat-patches/0002-ns.inum.patch |  25 ++++++++
>  net/batman-adv/debugfs.c          | 130 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 152 insertions(+), 3 deletions(-)
>  create mode 100644 compat-patches/0002-ns.inum.patch

Matthias is against applying [1] patch 6 because it would require that
batman-adv supports this interface for a long(tm) time. He proposes to use
netlink instead.

Andrew, do you want to change patch 6 to avoid creating the debugfs stuff in
non-init_net netns?

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014690.html

--nextPart42883157.KAQGEl6LGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5pkkAAoJEF2HCgfBJntGrDMQAMACBvcrZ0eZu97hWz6pyTsJ
Y5SgKt6xckNpYME4Y0REQAlzQ3hk5WliVCabw8m15BP4d57ABLLDf+TEflcFONl4
vEvUOgGaevTpQJVh201ecvAqpakcEyZ/bO7r9kw7JZPGcoDl81KHiM1bH+CmiMIn
mupYkfOGyDiH0ayymtyZp1E70MEHCnuIzLaVSJ04ivNHmVGVYITZF3t3zl2R3aIP
y+8Y7h33vQopckNPKLfz48tyQP4u1cYCc1sDGgUiK9rBZxEet+L5kMiC5ThHnKe4
YqznmEBWfwtlLuFFlVWS+u9IFEsg7GyBs9TM17yJgJsLLu424cQNhZxy4BE/9SSy
7OABAUdcLPGyQIMEOG7e8MxSw1KN8ZCncOOeAuZGNwNfx2yTT65XW976KOqL2IEi
loklK0K4qYbzfSP4HovB715VKx1Zb7MjmKn32+3S4oJ+dgt1aoR4IH0mdhcDjUBk
8eXQqXSZbRiVHu+Wx2gtEdX2gIrh1qoAGJsmLMsCqru48RcdNKbnWlnBIiz4lh2o
kRpijoOIyVa6h/Ej1B16O1mqmDl/pBYLTAYiL2OoxeecUEWS2dakg6l0MX93YRLX
69lZi9xNL0VXE8GUON3SAGlbgUQXN5wf13FjGCOuJTaRI/0IFe349mOBdPhmwH66
ObYMsIE6GZ4Oun1m4WxX
=tNsc
-----END PGP SIGNATURE-----

--nextPart42883157.KAQGEl6LGP--

