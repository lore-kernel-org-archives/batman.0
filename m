Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 30 Nov 2018 08:41:35 +0100
Message-ID: <2508553.amZRsud9Hk@bentobox>
In-Reply-To: <1543561202-614-1-git-send-email-wen.yang99@zte.com.cn>
References: <1543561202-614-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3029363.zrB592PKAl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix null pointer dereference
 in batadv_gw_election
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
Cc: Wen Yang <wen.yang99@zte.com.cn>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, netdev@vger.kernel.org, zhong.weidong@zte.com.cn, linux-kernel@vger.kernel.org

--nextPart3029363.zrB592PKAl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 30 November 2018 15:00:02 CET Wen Yang wrote:
> This patch fixes a possible null pointer dereference in
> batadv_gw_election, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./net/batman-adv/gateway_client.c:289:15-24: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:290:15-29: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:291:15-29: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:292:15-27: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:293:15-27: ERROR: next_gw is NULL but dereferenced.

This patch is seems to be nonsensical. next_gw cannot be NULL at this point 
(let us call this location in the code "4."). Let us go through the code

    // 1. when both are NULL then it would jump out of the the function.
	if (curr_gw == next_gw)
		goto out;

    [...]

    if (curr_gw && !next_gw) {
        [...]
        // 2. this handles the only valid case when next_gw is NULL
    }  else if (!curr_gw && next_gw) {
        // 3. here we know that next_gw is not NULL and curr_gw is NULL
        // we can therefore infer that 
        [...]
    } else {
        // 4. here you try to add an ugly patch to handle a non-existing 
        // next_gw == NULL case
        [...]
    }

Let us go through all possible combinations:

        curr_gw  next_gw
    I   0        0
    II  x        0
    III 0        y
    IV  x        y

For I:   we would leave the function even at 1. and never reach 4.
For II:  would be handled by 2. and thus never reach 4.
For III: would be handled by 3. and thus never reach 4.
For IV:  This can be handled by 1. (when x == y). Or otherwise it would be
         handled by 4. but is not the next_gw == NULL case.

Please correct me (in case I missed something) but it looks to me that this 
patch should be rejected.

Kind regards,
	Sven
--nextPart3029363.zrB592PKAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwA6a8ACgkQXYcKB8Em
e0ZMiw//abzOV72YH6n3yUp00BPlx2pZmZgzxrAV09jzFebl+HskKMBYN/PL4opu
xqu9Rimo5787LRBOT2gsTok3Xo0gfNUa43DsHxP1+XHByRKTHIbDLlOia3kmIE8w
5XZ4CO/RW5c0Oix9HTz2Shjuc/w4HjYJDiqZaVP19lhFv2Y+hx+ybT+CLdU7dm5S
n9SFY/QSWVEYpGR4SKM4BtS7UW1ph+yntja61JkC4lwh2VnQIblzy5OHzLHmmdB+
iQ7FAI6pvUjcXbOSoowM6Z9Xxty3m9ZppEvEZ5DllpVpO+mWV02Lcln+ePxY/NVI
lOlxJBg5+9uuWtmvOVdygKp+51MgrGYNgvoYZJfbf/AOpamNgB78t81EOt4tMquV
VRij3jgE4vxB2Ee0Lk3MP3SVd2ECH2HbHkfv+UulBEAXmeMbqkZjRnDQWfkWzMd2
dIbNzKIvH13quxu3WgzoNQHco5pmdFT+FXpX57mYybvTUlweCUCubZo1MyvO5kM3
GrU/7EGpzKWORi13v+I+LUDOqprXZ9d8c6xqHNmucHlsdE22r6sqG/1rfjPnjGUw
MFzGgH+mq1LOZz6eNQIp7o4CUxYv2719EAhKBOCZE0+EQw3W2eoq/4SBvJB+j9im
bBkSbec80kUU6SxophKOJZDb/En5pxx9i45g3N7UwYZvnCzzudE=
=aQHz
-----END PGP SIGNATURE-----

--nextPart3029363.zrB592PKAl--

