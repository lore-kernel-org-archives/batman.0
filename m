Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 15:51:32 +0800
Message-ID: <4054492.7ouEHkgyCf@voltaire>
In-Reply-To: <1458473273-8769-1-git-send-email-sven@narfation.org>
References: <1458473273-8769-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7153813.yLa45mSVQ1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Reduce refcnt of
	removed router when updating route
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

--nextPart7153813.yLa45mSVQ1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 20, 2016 12:27:53 Sven Eckelmann wrote:
> _batadv_update_route rcu_derefences orig_ifinfo->router outside of a
> spinlock protected region to print some information messages to the debug
> log. But this pointer is not checked again when the new pointer is assigned
> in the spinlock protected region. Thus is can happen that the value of
> orig_ifinfo->router changed in the meantime and thus the reference counter
> of the wrong router gets reduced after the spinlock protected region.
> 
> Just rcu_dereferencing the value of orig_ifinfo->router inside the spinlock
> protected region (which also set the new pointer) is enough to get the
> correct old router object.
> 
> Fixes: d90ddb94423f ("batman-adv: Make orig_node->router an rcu protected
> pointer") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> --
> v2:
>  - add comment explaining the idea behind the extra
> rcu_dereference_protected ---
>  net/batman-adv/routing.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied with minor modifications in revision 08ba64d.

Thanks,
Marek

--nextPart7153813.yLa45mSVQ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW95EEAAoJEFNVTo/uthzAOW4H/iV/pKPysvBgFi6XKrtBTF7h
z7CO2UGGHWl3sqAhKsfxEj7raVKPGPUSDrkQ2wzAYF22jDjSbGDRIdxV/KIqHf9l
E8RvMpUajJs0SUtSNxLsuA9kkoTGA0Ox9ZWSsi35XbSGYWfCxmUItOfQCtCh/J8T
bPNtFYQn5T6yBDNi8ss1NTOF/92Ph/OxbU5pQpm02dDfFi9b7aglkIHySpnu2UsP
u6ku/Z7uJnNGuR3gmJESpaj6fNY0dMAIL5VKPv9U3T89aoSzA8EZty1joxijf/Dg
kbFF0nufcQ4ScF9nzkU/beKKdM/harl/FOi/kSAGNX6/Rxvsr47cOZNmutSKSaw=
=FMTx
-----END PGP SIGNATURE-----

--nextPart7153813.yLa45mSVQ1--

