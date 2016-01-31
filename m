Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 Jan 2016 14:26:38 +0100
Message-ID: <76541057.mOyc0Z9Mdy@sven-edge>
In-Reply-To: <1453312110-32683-4-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3383721.d52oLn0xu0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
	in a different netns
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

--nextPart3383721.d52oLn0xu0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 January 2016 18:48:29 Andrew Lunn wrote:
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> nameplace, so also retrieve the parents name space when finding the
> parent.
> 
> Additionally, veth devices come in pairs and they are each others
> parents. Don't infinitely recurse in this situation.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/hard-interface.c | 44
> +++++++++++++++++++++++++++++++++++++++-- 1 file changed, 42 insertions(+),
> 2 deletions(-)
> 
> diff --git a/net/batman-adv/hard-interface.c
> b/net/batman-adv/hard-interface.c index a5ce58a..8d51a4a 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c

Include missing:

#include <net/rtnetlink.h>

> @@ -75,6 +75,39 @@ out:
>  }
> 
>  /**
> + * batadv_mutual_parents - check if two devices are each others parent
> + * @net_dev - 1st parent
> + * @parent_dev - 2nd parent
> + *
> + * veth devices come in pairs and each is the parent of the other!
> + *
> + * Return true if the devices are each others parent, otherwise false
> + */
> +static bool batadv_mutual_parents(const struct net_device *dev1,
> +				  const struct net *dev1_net,
> +				  const struct net_device *dev2,
> +				  const struct net *dev2_net)


 * What is net_dev and parent_dev?
 * Missing parameter docs are:
   - dev1
   - dev1_net
   - dev2
   - dev2_net.
 * Return -> Return:

Kind regards,
	Sven
--nextPart3383721.d52oLn0xu0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWrguOAAoJEF2HCgfBJntGh/wP/A4rErC/G6SOYxzpJpKgT2qM
1gAbyGwO9VXBRjAnA7TKTQMSZLTDCS5OR+qEYsvfoaDAi3WKdPadoIGIUacecfEE
+iSr4H/+9YkgkL8CZIQVB+Kc5xh7lKdgN4qIuGqDz4qZN6Wqo3jhhLgLCApDMEkk
4KXXKONwj07ReLQPb0cJsjouacnfqznkhQg8Pza4V0PBSpUac7RfFEPcwIXdpd+L
MRToc8lc8a5gSTTXSRso7Bz3tTZOqJ2sJWmi1CfC8DUTjytz0cn3PUcf795PSI4o
/Fo5Myl6/UPJ/p+e7yPtRlgapVmeX9rk9DcmcASjv/e/UG0haQfX1JMJz6Jzx4KA
FMQT+Im+tqc291s4HGn1coCtGkeBzsfmwmUMzPseFtB49+tH3GjEeoqAl9A+g8FM
4nVChw4UHmYWks7jRtc9mJQF1jTWzrNHU5TUDPAxl0fwhZVuH9/TEyp/+F//Gnup
l8rw/bsw5gtug9PUXsTmVkqoiBBbgoG8nmRMNReO9PK/AKcGv+uzFNtAcAwasHx4
73ntODqPSBlmda7GQaVd/aBfRdGzQQ48kX6DOK0M6RVW9K/x5ypPHLmQaarjBs9m
p9xJ4rKn44iynzi9aZXcbGqbl+UTEUbBtsDioPWnH1D3uNmzbKoHi0qyLJm0Cr2E
NFNzTOpyDccXVk+S4JJh
=iGpM
-----END PGP SIGNATURE-----

--nextPart3383721.d52oLn0xu0--

