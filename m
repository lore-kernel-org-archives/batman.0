Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Jun 2016 16:36:47 +0800
Message-ID: <18352303.nIKADFaKRH@voltaire>
In-Reply-To: <1465796492-5039-2-git-send-email-sven@narfation.org>
References: <1465796492-5039-1-git-send-email-sven@narfation.org>
 <1465796492-5039-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1664274.iQ0h2B42lB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/4] batman-adv: Modify mesh_iface
	outside sysfs context
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

--nextPart1664274.iQ0h2B42lB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 13, 2016 07:41:30 Sven Eckelmann wrote:
> The legacy sysfs interface to modify interfaces belonging to batman-adv
> is run inside a region holding s_lock. And to add a net_device, it has
> to also get the rtnl_lock. This is exactly the other way around than in
> other virtual net_devices and conflicts with netdevice notifier which
> executes inside rtnl_lock.
> 
> The inverted lock situation is currently solved by executing the removal
> of netdevices via workqueue. The workqueue isn't executed inside
> rtnl_lock and thus can independently get the s_lock and the rtnl_lock.
> 
> But this workaround fails when the netdevice notifier creates events in
> quick succession and the earlier triggered removal of a net_device isn't
> processed in the workqueue before the adding of the new netdevice (with
> same name) event is issued.
> 
> Instead the legacy sysfs interface store events have to be enqueued in
> a workqueue to loose the s_lock. The worker is then free to get the
> required locks and the deadlock is avoided.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v5:
>  - rebase on top of current master
> v4:
>  - rebase on top of current master
> v3:
>  - rebased on top of current master to fix conflicts with newest patches
> v2:
>  - rebased on top of current master to fix conflicts with newest patches
> ---
>  net/batman-adv/sysfs.c | 107
> +++++++++++++++++++++++++++++++++++++------------ net/batman-adv/types.h
> |  13 ++++++
>  2 files changed, 94 insertions(+), 26 deletions(-)

Applied in revision a1f0a80.

Thanks,
Marek

--nextPart1664274.iQ0h2B42lB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXZ6sfAAoJEFNVTo/uthzAbAMH/0JN68UeFKGQKGdXPd6hTRUB
ciJmmqgqimcRAbf5bAehNI+E+vfd1qHnwLK/x89dbLNhgg2tg/h2voIttDVfPR89
qBEpQQv4Zk5CREFjuVmoQE3xyzKpkZH4v/y9kFDho4OfwbHS9Z5fW6uLC5TEKisC
+7fLy/mZgGB8SkF80T1XL8PciC6j9UfAkF0AvAWTzJ3dXyDVWm1bytD9wwoIoQmv
tQ6dYQRAbqs33qVNI9G1Bp+zDBCjmrC7sGYhkskI8pliGPtJjb1enqSrLmJyT0RY
rMmfTMXsfurcPCMmxJ16yo6oAXSRvx2Alqk9BaSvQy33V5V5LdeSNwxkUwezONU=
=9QMm
-----END PGP SIGNATURE-----

--nextPart1664274.iQ0h2B42lB--

