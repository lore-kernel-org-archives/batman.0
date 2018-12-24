Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Dec 2018 19:46:32 +0100
Message-ID: <3515548.IyJqbIalli@sven-edge>
In-Reply-To: <20181224174926.20321-1-pakki001@umn.edu>
References: <20181224174926.20321-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart140518754.v2Ycy2XqpW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv/main: Fix check on return
 value of rtnl_link_register
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
Cc: Aditya Pakki <pakki001@umn.edu>, Marek Lindner <mareklindner@neomailbox.ch>, kjlu@umn.edu, Antonio Quartulli <a@unstable.cc>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

--nextPart140518754.v2Ycy2XqpW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 24 December 2018 18.49.26 CET Aditya Pakki wrote:
> rtnl_link_register() may fail and can impact registering the device.
> The fix checks the return value and pushes the error upstream.

Regarding the commit message - what is "batman-adv/main"? Shouldn't this be 
"batman-adv: "?

And the device can still be registered without batadv_link_ops - just not 
using rtnl.

Kind regards,
	Sven

--nextPart140518754.v2Ycy2XqpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwhKYgACgkQXYcKB8Em
e0ZL0RAAxtawbTcwqlL8r79AWaXuiWh9o+J0ZZVRd+9hjfA0RnJpRgf66Q7Itas2
EjXOaPjvEwNXG3fNORRMjvaFrjitPTjahyJiYVjlsF8D09rZkCRBQ2DtkEFKuQFG
GvYYbtd0zB1FYEQuA6P7j+TMi9Iocpy+afeVTFdgKzJfRe9n1uiqSiNxvLyTdv8g
DpZ054QKXhD2EpJxDT5RF6mJMeWnHqj4DYQ9jWyLk0IYicPYrByIN1QPBlwYYBR7
fHYXGT2g+4IWIOPZa2slbmr/U5FEK8kjAqtfhK98zR+MnsRH2oB+JGONmELzINRb
aGcGgw7pDmvVEX+myqFPWI6hPWwvYOyLIeVwW7qdTSMpmZyT1r5znw2hx7TzFwMj
jRplEh3kUkP1wVn+D91G9JxAvMxbZyecCv9rLgEnLRk86aqH5e+mKTt/UmM1bcOp
zKrw8VnSzC/e6VURdGE1ZTAu3XOerQpD7tW+ZSW39zJ/uZNWM0nxHhHdX4qyW2wu
Hn/V11b8uwzzZZ6ZCfq2LLucdNqk2rwQx/a5hYneWsx+3t7tQE2PUo2uLzRRjBhU
OQaIdZQZQPwOpXv57xKWUAzZdyt8VRf4qtXFCzxScHtGPd6tuk+aRdUKbj4DgIl9
HRhcp6U5ZIaJijiFbi6gvpAGFtv0lz04jxqSgz3MvaLiTVNLUFk=
=8Nd8
-----END PGP SIGNATURE-----

--nextPart140518754.v2Ycy2XqpW--



