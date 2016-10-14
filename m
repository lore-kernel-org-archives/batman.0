Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 14 Oct 2016 15:33:44 +0200
Message-ID: <56788276.hNFQLni3DR@prime>
In-Reply-To: <20160922214607.22123-1-sven@narfation.org>
References: <20160922214607.22123-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3342049.tLUy0tK4Fn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: vis: Fix netlink function
	fallback
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

--nextPart3342049.tLUy0tK4Fn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, September 22, 2016 11:46:07 PM CEST Sven Eckelmann wrote:
> The netlink functions return -EOPNOTSUPP when the kernel doesn't support
> the netlink command. The caller can then fall back to debugfs. So check for
> -EOPNOTSUPP and not EOPNOTSUPP.
> 
> Fixes: bca55a86fecd ("alfred: vis: Add support for netlink")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 2208996.

Thanks!
     Simon
--nextPart3342049.tLUy0tK4Fn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYAN64AAoJEKEr45hCkp6h6pAQAKao0grjSOUWBEkkOjxCfPko
wnoRPh7rJoNSDialbVE1uzIqPJFWlpSuD2C4HmxqIGpyCC/l4yicUge9ukYMiIHg
Jm5NYRrf2N4eiNoQtIJzXfNsth5UaY7w839ZO2CVCjAKhvpwS0yRLzVaPASsA6bG
xZBKu/e2zxKewMIPfLt7gs/y+KKZPWgoo+MvRDL609ZvBen2P7fVgr3pjmSxC1GV
5Vj//YI5c2CZKyQ9Ulguat30RORtKKtVRDXjUCnASrQXoXTtikAPz5tPQm6gPZuF
MXivg98/v9FTVv9/Ne2w62WY18lTrWdB4k7OAeKY/E6cMngpcm+2bDGAFD6B5oBB
hDA9+W/AIDjaSsul8YjizR6ifFoxcHjXek4ykUfvLbnSeCzUB1SD7CLqllXfUkaq
Xf7PiV1Lpt77Z8kfjX1Abt9lH2LI4mmH7pr/h8zZa3yISCDZWspaOy8n+QeRb5J1
DN9RLBp3wYiTA4BoUokF9lpAfUZk6IwrTR5MYR4ajwO6dnIr2rS8cHG4vZtMRYek
QBzO9jPkE1Kv6iDHLZEBRj0CF37uW/PEQpm+3v8eUt0K6xC6dPCjigxazMuARle2
nv24QcQWkMZo499YhZ2SW3+xwYvdFeFz+b8+TD+98rvqGnJdERqaG0YP1Bsb5yLQ
9Vt1kFF/JC7kDyubXrVW
=r828
-----END PGP SIGNATURE-----

--nextPart3342049.tLUy0tK4Fn--

