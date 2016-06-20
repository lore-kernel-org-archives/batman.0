Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Jun 2016 16:37:41 +0800
Message-ID: <5935107.moVPDjaayx@voltaire>
In-Reply-To: <1465796492-5039-4-git-send-email-sven@narfation.org>
References: <1465796492-5039-1-git-send-email-sven@narfation.org>
 <1465796492-5039-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1494457.PuT8OmLYcd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 4/4] batman-adv: Avoid sysfs name
	collision for netns moves
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

--nextPart1494457.PuT8OmLYcd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 13, 2016 07:41:32 Sven Eckelmann wrote:
> The kobject_put is only removing the sysfs entry and corresponding entries
> when its reference counter becomes zero. This tends to lead to collisions
> when a device is moved between two different network namespaces because
> some of the sysfs files have to be removed first and then added again to
> the already moved sysfs entry.
> 
>     WARNING: CPU: 0 PID: 290 at lib/kobject.c:240
> kobject_add_internal+0x5ec/0x8a0 kobject_add_internal failed for batman_adv
> with -EEXIST, don't try to register things with the same name in the same
> directory.
> 
> But the caller of kobject_put can already remove the sysfs entry before it
> does the kobject_put. This removal is done even when the reference counter
> is not yet zero and thus avoids the problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v5:
>  - rebase on top of current master
> v4:
>  - rebase on top of current master
>  - avoid deletes of vlan->kobj when it is a pointer to bat_priv->mesh_obj
>    (happens for untagged vlan and can cause some kernfs warnings)
> v3:
>  - rebased on top of current master to fix conflicts with newest patches
> v2:
>  - rebased on top of current master to fix conflicts with newest patches
> ---
>  net/batman-adv/sysfs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied in revision bebf178.

Thanks,
Marek

--nextPart1494457.PuT8OmLYcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXZ6tVAAoJEFNVTo/uthzA2s4H/Rwiuwv/paHC9dog1pXjVNVr
ulxwUB+XfFFbIOiAxUee4wcaPY2wIis4J8DkdQbtc4RVi8U7gkt5mAeoKsY5Wa7I
6IZsPau6SbYpA5QeJrpjvRg4RYN02ymAj4OYXMeNJv/2flyLB6j9U6i+rfxLHm2Z
IQX9sUxP30t+P+hIH45r4uQNKAgZPin1x1mV9F9RA/0aeYuda/iYK7G6rX0wRQpb
3NmathKq4Js31tENee+viiQ+zTNM4gbFt1/eQfkXxNDBOvbB/3DIH5GRl64SJnll
S9mKmj97cSersyCfFFCeJN5ZunuDv6ijtycZmU5Jc+aSfjmA3Vii0Hmlgy1Tzzk=
=5CA0
-----END PGP SIGNATURE-----

--nextPart1494457.PuT8OmLYcd--

