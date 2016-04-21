Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Apr 2016 18:12:42 +0800
Message-ID: <58450790.kUnEmWRFah@voltaire>
In-Reply-To: <1460597825-22660-1-git-send-email-a@unstable.cc>
References: <1460597825-22660-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2042276.pO0nqJvNY3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N V - make sure
	iface is reactivated upon NETDEV_UP event
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

--nextPart2042276.pO0nqJvNY3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, April 14, 2016 09:37:05 Antonio Quartulli wrote:
> At the moment there is no explicit reactivation of an hard-interface
> upon NETDEV_UP event. In case of B.A.T.M.A.N. IV the interface is
> reactivated as soon as the next OGM is scheduled for sending, but this
> mechanism does not work with B.A.T.M.A.N. V. The latter does not rely
> on the same scheduling mechanism as its predecessor and for this reason
> the hard-interface remains deactivated forever after being brought down
> once.
> 
> This patch fixes the reactivation mechanism by adding a new routing API
> which explicitly allows each algorithm to perform any needed operation
> upon interface re-activation.
> 
> Such API is optional and is implemented by B.A.T.M.A.N. V only and it
> just takes care of setting the iface status to ACTIVE
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
> 
> Changes since v1:
> - added kerneldoc for bat_iface_activate
> 
>  net/batman-adv/bat_v.c          | 12 ++++++++++++
>  net/batman-adv/hard-interface.c |  3 +++
>  net/batman-adv/types.h          |  3 +++
>  3 files changed, 18 insertions(+)

Applied in revision 69cfb8b.

Thanks,
Marek

--nextPart2042276.pO0nqJvNY3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGKeaAAoJEFNVTo/uthzAI8oH/j1LK6bezLGJXxV9PrUa55B2
mU23VejhqoRHL784w0sN6KUtaELEWQQNnNRWxswzNZ0o4FAl+qGx4rC1QLY1BBXQ
WeAghDTEIWtRFSQ7ErGLtdbA8glpmIvDxm0tpbAmKyWatQtBOG6RFz8wf16a0V65
s6TfPFYo5+h+nFynDgK2Zbd4tt02QAg0kKEqeYHcNw1JiGvq+6/UhCLNpc+B/VFB
7xdeKXi45wzGKErFeMTArm+cGDgd1MNaWN0/+mTTdeRkAotwa/oknmIxWWJKfbIp
sSheIdOTb5OAkrxCwH+8nYrngpVY+ZSP7ecbNlm5TH5ozso9hefs/x3z8/LLrj0=
=ttzB
-----END PGP SIGNATURE-----

--nextPart2042276.pO0nqJvNY3--

