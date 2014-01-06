Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jan 2014 16:43:09 +0800
Message-ID: <1689948.JcGQ6VuExe@diderot>
In-Reply-To: <1388960736-3873-3-git-send-email-antonio@meshcoding.com>
References: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
 <1388960736-3873-3-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5133806.sHkqzavcf5";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 next 3/3] batctl: add sys framework for
	VLAN support
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
Cc: Marco Dalla Torre <marco.dallato@gmail.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart5133806.sHkqzavcf5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 January 2014 23:25:36 Antonio Quartulli wrote:
> From: Marco Dalla Torre <marco.dallato@gmail.com>
> 
> Allow the batctl tool to take advantage of changes from commit
> e4ff5c153dab054a6cd1c4132f87bc5e77127456 "add sys framework for VLAN"
> recently added to batman-adv, so that users can execute commands in
> a per VLAN fashion.
> 
> If no directory entry corresponding to the user-selected device is found
> at the standard location for non VLAN interfaces
> (/sys/class/net/${device}/mesh/), 'batctl' now looks into directory:
>      /sys/class/net/${base_device}/mesh/vlan${vid}
> Information on VLAN devices (base device, vid) necessary to construct the
> directory path is acquired by querying the netlink kernel module.
> Where:
>     -${base_device}: the batman device on top of which the VLAN is sitting
>     -${device}: the device interface for the VLAN,
>     -${vid}: the identifier assigned to the VLAN.
> 
> If the user-selected command is not supported by the VLAN, an appropriate
> error is shown.
> 
> Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  main.c       |  2 +-
>  man/batctl.8 |  4 ++--
>  sys.c        | 15 +++++++++++++--
>  sys.h        | 22 ++++++++++++----------
>  4 files changed, 28 insertions(+), 15 deletions(-)

Applied in revision 03eaa85.

Thanks,
Marek

--nextPart5133806.sHkqzavcf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSymydAAoJEFNVTo/uthzAyJ4IAIQFC6eWTBJaKKX2fDR4i3na
F+PVAjKkyT4tGxLsQAouvjpdacDgbQdqEGV9m5o9Wm9VAUu6BZ1q9pUyJlpkgoFV
OS17efC6p8Sl2O0OvPjw3tVJuENhefIkVBRBlpcMkvtVDFnTWeawq0v9P9D5ymZp
OjecY/LnMId9wRF960ZebHgZ36eblLh8utLApXFUSuAE4JjsYoA8/EYz2cqDzv0o
3zcPxtbExz+o9pq3+kV8uHEGjb70MKxLC43eAx9zMmbKWblJuDP0gO91Yogou5Np
O5A0+Ik8T7NujuZpD4go2OcZUMpWKMySv4pQrd6R+cwzXZTir2NhDNtz3wLEC0c=
=T2zo
-----END PGP SIGNATURE-----

--nextPart5133806.sHkqzavcf5--

