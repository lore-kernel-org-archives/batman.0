Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 15:56:26 +0800
Message-ID: <3726612.XJImn6soOJ@voltaire>
In-Reply-To: <1467542795-29647-5-git-send-email-sven@narfation.org>
References: <1467542795-29647-1-git-send-email-sven@narfation.org>
 <1467542795-29647-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3255807.8sGjtkMQyM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 4/4] batman-adv: disable sysfs knobs
	when GW-mode is not implemented
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

--nextPart3255807.8sGjtkMQyM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 12:46:35 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> Now that the GW-mode code is algorithm specific, batman-adv expects the
> routing algorithm to implement some APIs to make it work.
> 
> However, such APIs are not mandatory, therefore we might have algorithms
> not providing them. In this case all the sysfs knobs related to GW-mode
> should be deactivated to make sure that settings injected by the user
> for this feature are rejected.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v6:
>  - no changes
> ---
>  net/batman-adv/sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Applied in revision 633703f.

Thanks,
Marek

--nextPart3255807.8sGjtkMQyM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe2gqAAoJEFNVTo/uthzAF/4IAI2QdYh4wQuSO6NxDzXyB91L
FkmMn5BKuUq61qb18G1kfitEQO9YNpwMykmVX1lMk7V3hjo9fhtsFhKfpqijAJL5
ErMR6cq1alikzu2G+NLE43KBroECTb+UQHp+dPyzQ806KvO+VoJq4K+xtlbOeTM/
MSxwTlwRiG99GCHJu94vogwmwl47+/UuKPvbBZx/+7EiBqr+m5iFSNjkmq4nmNVQ
XYf08XJFjMnv5J98U3yxOtz/pfJUT8n64jWqh8rD51AFa2VkVSnOyUOC53uSXz2W
DuVw1jrN5OJazAR7kMdBKTl1Hs7cgXvJE3ihMfbzYfun6cFCOd0M6/2i+1qjrhs=
=BpYw
-----END PGP SIGNATURE-----

--nextPart3255807.8sGjtkMQyM--

