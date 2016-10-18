Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:26:11 +0200
Message-ID: <2395714.LduUx5Iunq@bentobox>
In-Reply-To: <1468697424-10701-1-git-send-email-sven@narfation.org>
References: <1468697424-10701-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3047141.NTL25xWOBE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [maint,
	1/5] batman-adv: Add BATADV_DBG_TP_METER to BATADV_DBG_ALL
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

--nextPart3047141.NTL25xWOBE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 16. Juli 2016 21:30:20 CEST Sven Eckelmann wrote:
> The BATADV_DBG_ALL has to contain the bit of BATADV_DBG_TP_METER to really
> support all available debug messages.
> 
> Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/log.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in fcf6a3a20f1ca1ecf248ae576d0bd425e1fc96d6 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/fcf6a3a20f1ca1ecf248ae576d0bd425e1fc96d6
--nextPart3047141.NTL25xWOBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgbTAAoJEF2HCgfBJntGrigQALkZFDDjmoJr5ETuVXwvSKA3
XzsjvVxtbvPD2qfJlDnzBqY+ofBqCO3+8XgTUpyU+MdkPbPO8RMs6zRwT+XJG8H4
3120R7j/Yg0WzTG0Z/6I/uRn7K7szF3lTKBeEgakLULYjddJcInJ899baRPhuRwR
oyzX4qDOhCBi8rIFU9I7sK9OhERsVRBJVZp5RyrUApPqbE3iNBkD9X64jzih6QpQ
iQ1A4qJxAvB6bjLKjS+EXU2a5jFbGjAYqi8jinOWAQzu8JtNI84Sv/xyp1eJJR1D
2N8xzVD/yyzLKk4zDzsq7WMQn76XivXeVk2dSsxBWWymTO+EmW7crsy9Tts17h4e
xYOt1iymsY6qO3hYbj3u0hYm1m8KMIKMkoo7RHOR7zLcg62rjDkMmeo5j73b+bnv
Yr4KmXpKafODcEAULLFfm9xcXmIn5zQFSL9SuaBuJCCtcF3hzGKSlJs4drbgsrcf
xNlY6/8OROfM6Lxy+feIfGqDEL2ZgUMh193H7wQmYFAT2oNsZCSL85d94jihmKsN
I6BJ88yF/Omlv5C7Z4lHIunpwSQTtmdVAKaFelr15b/6TITos45Xojzr+L9afB1u
be9S071+iCtU6eHxz5W/NFaKqkziJYi0Y3+byGAZhGiMwgu/Vrw5FhNmNL/tBBGu
x5kYMKIG6aDpo0wM1s0+
=9t9i
-----END PGP SIGNATURE-----

--nextPart3047141.NTL25xWOBE--

