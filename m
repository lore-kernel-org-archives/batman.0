Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:22:09 +0800
Message-ID: <2738035.KKfpO6mouK@voltaire>
In-Reply-To: <1452933619-6712-9-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-9-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2619688.c7CzRKucLM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 09/12] batman-adv: ELP - compute the
	metric based on the estimated throughput
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

--nextPart2619688.c7CzRKucLM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:16 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> In case of wireless interface retrieve the throughput by
> querying cfg80211. To perform this call a separate work
> must be scheduled because the function may sleep and this
> is not allowed within an RCU protected context (RCU in this
> case is used to iterate over all the neighbours).
> 
> Use ethtool to retrieve information about an Ethernet link
> like HALF/FULL_DUPLEX and advertised bandwidth (e.g.
> 100/10Mbps).
> 
> The metric is updated each time a new ELP packet is sent,
> this way it is possible to timely react to a metric
> variation which can imply (for example) a neighbour
> disconnection.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  compat.h                   |  21 +++++
>  net/batman-adv/bat_v.c     |   3 +
>  net/batman-adv/bat_v_elp.c | 207
> +++++++++++++++++++++++++++++++++++++++++++++ net/batman-adv/bat_v_elp.h
> |   2 +
>  net/batman-adv/bat_v_ogm.c |   2 +-
>  net/batman-adv/main.h      |   4 +
>  net/batman-adv/types.h     |  16 ++++
>  7 files changed, 254 insertions(+), 1 deletion(-)

Applied in revision 5c32451.

Thanks,
Marek

--nextPart2619688.c7CzRKucLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlShAAoJEFNVTo/uthzAGEkH/i0xpL7F2yjVMSTqW6eiH1hr
0G7GfI9DvBANdAwsuiIxmE6ewl5hWifHpQzBoocuJNYeZpsMGuyHBAiA9TliUXui
iGaRzJgoDfRzJ4MCMDVnCCRjueO2OTcHHe6PKI+jFekSk2y5b8UX+XCK28lJt3jm
pXi04l5C/qVWyENityRg3WbKehiaiy3vP9h8dth3OIJuZXctX5KKpQoEHVuUCMyp
+Y+B+rYS8sQ0tLf7D6tZy/M4C+7+DpqEHv7lcxVz/gOS3IjH7S+tzqHbLZ18YjQa
ABAdXw9JPwavPAAHMySd2Oi+/ro0gxoNtwV/Jy6g69/RnB9oviNxom0EWDnn3wU=
=vE7R
-----END PGP SIGNATURE-----

--nextPart2619688.c7CzRKucLM--

