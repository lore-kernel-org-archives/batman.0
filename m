Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 08 Aug 2015 00:48:11 +0800
Message-ID: <2129549.sqPbc6jJBU@voltaire>
In-Reply-To: <1438719979-15778-1-git-send-email-antonio@meshcoding.com>
References: <1438719979-15778-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3125447.5E60klGhNB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: don't access
	unregistered net_device object
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


--nextPart3125447.5E60klGhNB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, August 04, 2015 22:26:19 Antonio Quartulli wrote:
> In batadv_hardif_disable_interface() there is a call to
> batadv_softif_destroy_sysfs() which in turns invokes
> unregister_netdevice() on the soft_iface.
> After this point we cannot rely on the soft_iface object
> anymore because it might get free'd by the netdev periodic
> routine at any time.
> 
> For this reason the netdev_upper_dev_unlink(.., soft_iface) call
> is moved before the invocation of batadv_softif_destroy_sysfs() so
> that we can be sure that the soft_iface object is still valid.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  net/batman-adv/hard-interface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 958aafbb.

Thanks,
Marek

--nextPart3125447.5E60klGhNB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVxOFPAAoJEFNVTo/uthzAMnsIALfpy+z8muXQJvAOpC++/qdU
w+WR1KKBdr9FSVH00ORsuAMXSLItUhOBibbduw6M2/3CubQKpGetBQ2NqQNl5fch
wjySgKmos7kQxI1QaTPKhZeRL6XEBEISuv3msPx0tlok2eo3bgB3xSHymkk3lV4f
/8un2ipAkj8TKD+phXKgIyHp95e6GZNpwgIdZZGxUFBbUeqrGBYS6qbu94iew51i
vWZcOirhhHEBA6OuwX3/rsba2wYUvLBYnqU4VKr+cESrala2yNmGoBXV/Vj6Tbaq
LDd8s5qnODUbYNhSA8q+fzAikuizcW07sNnl0N4B5Bma89MjaYIIMAmpRno5jU8=
=GVuk
-----END PGP SIGNATURE-----

--nextPart3125447.5E60klGhNB--

