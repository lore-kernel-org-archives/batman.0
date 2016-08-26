Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 26 Aug 2016 17:10:34 +0800
Message-ID: <4597223.ello3TVbWB@voltaire>
In-Reply-To: <1470491452-14194-1-git-send-email-sven@narfation.org>
References: <1470491452-14194-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4669791.fVno5NVxZd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Add missing refcnt for
	last_candidate
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

--nextPart4669791.fVno5NVxZd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 6, 2016 3:50:52 PM HKT Sven Eckelmann wrote:
> batadv_find_router dereferences last_bonding_candidate from
> orig_node without making sure that it has a valid reference. This reference
> has to be retrieved by increasing the reference counter while holding
> neigh_list_lock. The lock is required to avoid that
> batadv_last_bonding_replace removes the current last_bonding_candidate,
> reduces the reference counter and maybe destroys the object in this
> process.
> 
> Fixes: 797edd9e87ac ("batman-adv: add bonding again")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch was only build tested.
> ---
>  net/batman-adv/routing.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Applied in revision 008afae.

Thanks,
Marek


--nextPart4669791.fVno5NVxZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJXwAeKAAoJEFNVTo/uthzAIR0H/i2g2Q6g5DZn6dNCnWdg1g0a
Mmu6a9wpX6mXs4DWmTwau74DDMVCALzU/MDYPMQQK30cgT2qEet7NxKAVxjEemcA
CfRBo8TElRKjnLrlf5fTzU66thdsx4dqmqNAsRxgHDV8I70M1Qv4dNuHuMOVgTsS
O/WXwAbsF8kNnQUVA0FSKuq95KTX5BkdCnkr1FuT8vuoWfZeMih3blU5pN5WNOy2
N1IsrmOAZ7d5PP6x4zefDvEtrEzGQvdSwaUiCPHScKrw8J+nGjolqyF/wy+Nam3K
05taROsaHusxcMRiYYYJYJ/n41yBh9xpNc6/V1ws7J6RUqgGD+QiG2PHWeiqku4=
=ilmn
-----END PGP SIGNATURE-----

--nextPart4669791.fVno5NVxZd--

