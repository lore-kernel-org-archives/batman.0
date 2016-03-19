Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Mar 2016 14:24:41 +0100
Message-ID: <1519541.sVhLMnezfA@sven-edge>
In-Reply-To: <1458392121-23608-1-git-send-email-sven@narfation.org>
References: <1458392121-23608-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1513250.az6WlLrWzF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deactive TO_BE_ACTIVATED
	hardif on shutdown
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, linus.luessing@c0d3.blue

--nextPart1513250.az6WlLrWzF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 19 March 2016 13:55:21 Sven Eckelmann wrote:
> The shutdown of an batman-adv interface can happen with one of its slave
> interfaces still being in the BATADV_IF_TO_BE_ACTIVATED state. A possible
> reason for it is that the routing algorithm BATMAN_V was selected and
> batadv_schedule_bat_ogm was not yet called for this interface. This slave
> interface still has to be set to BATADV_IF_INACTIVE or the batman-adv
> interface will never reduce its usage counter and thus never gets shutdown.
> 
> This problem can be simulated via:
> 
>     $ modprobe dummy
>     $ modprobe batman-adv routing_algo=BATMAN_V
>     $ ip link add bat0 type batadv
>     $ ip link set dummy0 master bat0
>     $ ip link set dummy0 up
>     $ ip link del bat0
>     unregister_netdevice: waiting for bat0 to become free. Usage count = 3
> 
> Fixes: 88861ea9acb7 ("[batman-adv] replacing if up/down timer with kernel
> notifications") Reported-by: Matthias Schiffer
> <mschiffer@universe-factory.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Please check https://www.open-mesh.org/issues/248 to learn more about the
> bug

I just want to emphasize that this patch doesn't fix the bug behind issue #248 
(only its main symptom described in the issue description). Please read the 
ticket and especially https://www.open-mesh.org/issues/248#note-4

Kind regards,
	Sven

--nextPart1513250.az6WlLrWzF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW7VMZAAoJEF2HCgfBJntGCkEP/1avO9Xe/tI5Df5YGbu1BSfU
66DLjBYEXFz+6kABbAAm+iLxcaLrlA+9DEBPtixOzTXVD2lVBX7knCaTBDwEfD/p
K7y8qb/8xJEtASmbrnNLdZTxneEKVWX1LVKVckUKGYeuFi2DwqcGVAEuDRKUZ/t8
B8HGf8f9dl52gfpC2dVPPYI93rH/V4KfYATf2s284bfQaxnhnF4JKa78iFi1qBB5
JAL8HFUssB1SZeMywCp1yfZwTXsGzWFsU3zvqVcXhldhh8CbXdgkqJqwI6hND4Sr
TSmbTwdUr2oJjRpNxhsNUvz2TBwzOsqVvNP7CIRTuQdPrXO+lUbhq9IeWzWDISW8
6jwNMNqfK7/DrGHfXXOTywb4HiYyXJxezt1kM3eUNYChNh1SNxqvogOPDYtQgCVR
amOKtxa1IBV1c/+Mbxy5XoWRpnJv+I0ddVGLPYMqyiLyHeJq5FrYlJLWlNlYR0ef
4aKnrYhDWZlzses8eTF3djqT6vyuriWC3y/LwwgpvhVnuhY8e541emcyEeal9wu7
nKLnF/qb7UxH5yOn99vppCNrkd3+C0rFrWhVATsfIbSw9fQauEB2adei1fkBsIdr
LtuSjbg7Lkp2lt12RqUVGpgNHwgnZhspEriI8It/IP3Iz7cuFk7vFdHLzLbET7Rj
PQVY2mEFgPdlm/GVFb9M
=wL0w
-----END PGP SIGNATURE-----

--nextPart1513250.az6WlLrWzF--

