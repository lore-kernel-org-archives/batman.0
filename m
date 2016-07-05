Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 17:18:56 +0800
Message-ID: <3255818.MVqnnubBri@voltaire>
In-Reply-To: <1467310246-5820-1-git-send-email-sven@narfation.org>
References: <1467310246-5820-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10410765.hbFHLhLZcx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/3] batman-adv: Fix orig_node_vlan
	leak on orig_node_release
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart10410765.hbFHLhLZcx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 30, 2016 20:10:46 Sven Eckelmann wrote:
> batadv_orig_node_new uses batadv_orig_node_vlan_new to allocate a new
> batadv_orig_node_vlan and add it to batadv_orig_node::vlan_list. References
> to this list have also to be cleaned when the batadv_orig_node is removed.
> 
> Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> --
> v2:
>  - nothing changed
> ---
>  net/batman-adv/originator.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied in revision 719afd2.

Thanks,
Marek

--nextPart10410765.hbFHLhLZcx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3uAAAoJEFNVTo/uthzAvzsH/iEgZtKUlSEoSfa5vIxq0Jhy
HtTgafTrvjEQGqA8Ig/WzlQC3x32wBNjDILF3vTcIiwPY8nWiBObz9YsKdHFLtTp
nP6kGSIx1vKDFmbQ6vcwNkZa2KGePDeFHpxAPfurvby2Ax+fSvz2i4KMibv/co0j
UIgztdzc3lQakMQce3In2QddMcXngIBFpYJ5DCIj1OCqSmvbvuR1lGd0juTlY+tb
4SXACF57cvYIO29kpkMXfsqXhl0HmD/JEFIxcuf0oJup+e6KXM0C6L6mzMpUXV5C
s3WL45cC8FnlVNhp2Tyxa0mYPnnUiPDQPgzOCdy17gkgqTmXED8Zp2IMRxCqMU4=
=VtDq
-----END PGP SIGNATURE-----

--nextPart10410765.hbFHLhLZcx--

